function Get-Weather {
  <#
      .SYNOPSIS
      Shows current weather conditions in PowerShell console.
       
      .DESCRIPTION
      This scirpt will show the current weather conditions for your area in your PowerShell console.
      While you could use the script on its own, it is highly recommended to add it to your profile.
      See https://technet.microsoft.com/en-us/library/ff461033.aspx for more info.
  
      You will need to get an OpenWeather API key from http://openweathermap.org/api - it's free.
      Once you have your key, replace "YOUR_API_KEY" with your key.
       
      Note that weather results are displayed in metric (°C) units.
      To switch to imperial (°F) change all instances of '&units=metric' to '&units=imperial'
      as well as all instances of '°C' to '°F'. 
       
      .EXAMPLE
      Get-Weather -City Toronto -Country CA
       
      In this example, we will get the weather for Toronto, CA.
      If you do not live in a major city, select the closest one to you. Note that the country code is the two-digit code for your country. 
      For a list of country codes, see https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#Officially_assigned_code_elements
       
      .NOTES
      Written by Nick Tamm, nicktamm.com
      I take no responsibility for any issues caused by this script.
       
      .LINK
      https://github.com/obs0lete/Get-Weather
      
  #>
  
  param(
    [string]$City,
    [string]$Country)
  
  
  <# BEGIN VARIABLES #>
  
  <# Get your API Key (it's free) from http://openweathermap.org/api and change the value below with your key #>
  $API = "8139cc6e0c2412ae08bf8bc815f87b77"
  
  <# Check if you have entered an API key and if not, exit the script.
  Do NOT change this value, only the one above! #>
  IF ($API -eq "YOUR_API_KEY")
  {
  Write-Host ""
  Write-Warning "You have not set your API Key!"
  Write-Host "Please go to http://openweathermap.org/api to get your API key - it's free."
  Write-Host "Once you have your key, change the value in the $" -nonewline; Write-Host "API variable with your key and re-run this script."
  Write-Host ""
  exit
  }
  
  <#JSON request for sunrise/sunset #>
  $resultsJSON = Invoke-WebRequest "api.openweathermap.org/data/2.5/weather?q=$City,$Country&units=metric&appid=$API&type=accurate&mode=json"
  $json = $resultsJSON.Content
  $jsonData = ConvertFrom-Json $json
  $sunriseJSON = $jsonData.sys.sunrise
  $sunsetJSON = $jsonData.sys.sunset
  $lastUpdateJSON = $jsonData.dt
  
  <# Convert UNIX UTC time to (human) readable format #>
  $sunrise = [TimeZone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($sunriseJSON))
  $sunset = [TimeZone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($sunsetJSON))
  $lastUpdate = [TimeZone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($lastUpdateJSON))
  $sunrise =  "{0:hh:mm:ss tt}" -f (Get-Date $sunrise)
  $sunset = "{0:hh:mm:ss tt}" -f (Get-Date $sunset)
  $lastUpdate = "{0:hh:mm:ss tt}" -f (Get-Date $lastUpdate)
  
  
  <# XML request for everything else #>
  [xml]$results = Invoke-WebRequest "api.openweathermap.org/data/2.5/weather?q=$City,$Country&units=metric&appid=$API&type=accurate&mode=xml"
  $data = $results.current
  
  <# Get current weather value. Needed to convert case of characters. #>
  $currentValue = $data.weather.value
  
  <# Get precipitation mode (type of precipitation). Needed to convert case of characters. #>
  $precipitationValue = $data.precipitation.mode
  
  <# Get precipitation amount (in mm). Needed to convert case of characters. #>
  $precipitationMM = $data.precipitation.value
  
  <# Get precipitation unit (mm in last x hours). Needed to convert case of characters. #>
  $precipitationHRS = $data.precipitation.unit
  
  <# Get wind speed value. Needed to convert case of characters. #>
  $windValue = $data.wind.speed.name
  
  <# Get the current time. This is for clear conditions at night time. #>
  $time = Get-Date -DisplayHint Time
  
  <# Define the numbers for various weather conditions #>
  $thunder = "200","201","202","210","211","212","221","230","231","232"
  $drizzle = "300","301","302","310","311","312","313","314","321","500","501","502"
  $rain = "503","504","520","521","522","531"
  $lightSnow = "600","601"
  $heavySnow = "602","622"
  $snowAndRain = "611","612","615","616","620","621"
  $atmosphere = "701","711","721","731","741","751","761","762","771","781"
  $clear = "800"
  $partlyCloudy = "801","802","803"
  $cloudy = "804"
  $windy = "900","901","902","903","904","905","906","951","952","953","954","955","956","957","958","959","960","961","962"
  
  <# Create the variables we will use to display weather information #>
  $weather = (Get-Culture).textinfo.totitlecase($currentValue.tolower())
  $currentTemp = "Current Temp: " + [Math]::Round($data.temperature.value, 0) + " °C"
  $high = "Today's High: " + [Math]::Round($data.temperature.max, 0) + " °C"
  $low = "Today's Low: " + [Math]::Round($data.temperature.min, 0) + " °C"
  $humidity = "Humidity: " + $data.humidity.value + $data.humidity.unit
  $precipitation = "Precipitation: " + (Get-Culture).textinfo.totitlecase($precipitationValue.tolower())
  
  <# Checking if there is precipitation and if so, display the values in $precipitationMM and $precipitationHRS #>
  IF ($precipitation -eq "Precipitation: No")
  {
  $precipitationData = "Precip. Data: No Precipitation"
  } ELSE {
  $precipitationData = "Precip. Data: " + $precipitationMM + "mm in the last "  + $precipitationHRS
  }
  
  $windSpeed = "Wind Speed: " + ([math]::Round(([decimal]$data.wind.speed.value * 1.609344),1)) + " km/h" + " - Direction: " + $data.wind.direction.code
  $windCondition = "Wind Condition: " + (Get-Culture).textinfo.totitlecase($windValue.tolower())
  $sunrise = "Sunrise: " + $sunrise
  $sunset = "Sunset: " + $sunset
  
  <# END VARIABLES #>
  
  Write-Host ""
  Write-Host "Current weather conditions for" $data.city.name -nonewline; Write-Host " -" $weather -f yellow;
  Write-Host "Last Updated:" -nonewline; Write-Host "" $lastUpdate -f yellow;
  Write-Host ""
  IF ($thunder.Contains($data.weather.number))
  {	
    Write-Host "	    .--.   		" -f gray -nonewline; Write-Host "$currenttemp		$humidity" -f white;
    Write-Host "	 .-(    ). 		" -f gray -nonewline; Write-Host "$high		$precipitation" -f white;
    Write-Host "	(___.__)__)		" -f gray -nonewline; Write-Host "$low		$precipitationData" -f white;
    Write-Host "	  /_   /_  		" -f yellow -nonewline; Write-Host "$sunrise		$windspeed" -f white;
    Write-Host "	   /    /  		" -f yellow -nonewline; Write-Host "$sunset		$windcondition" -f white;
    Write-Host ""
  }
    ELSEIF ($drizzle.Contains($data.weather.number))
      {
        Write-Host "	  .-.   		" -f gray -nonewline; Write-Host "$currenttemp		$humidity" -f white;
        Write-Host "	 (   ). 		" -f gray -nonewline; Write-Host "$high		$precipitation" -f white;
        Write-Host "	(___(__)		" -f gray -nonewline; Write-Host "$low		$precipitationData" -f white;
        Write-Host "	 / / / 			" -f cyan -nonewline; Write-Host "$sunrise		$windspeed" -f white;
        Write-Host "	  /  			" -f cyan -nonewline; Write-Host "$sunset		$windcondition" -f white;
        Write-Host ""
      }
    ELSEIF  ($rain.Contains($data.weather.number))
      {
        Write-Host "	    .-.   		" -f gray -nonewline; Write-Host "$currenttemp		$humidity" -f white;
        Write-Host "	   (   ). 		" -f gray -nonewline; Write-Host "$high		$precipitation" -f white;
        Write-Host "	  (___(__)		" -f gray -nonewline; Write-Host "$low		$precipitationData" -f white;
        Write-Host "	 //////// 		" -f cyan -nonewline; Write-Host "$sunrise		$windspeed" -f white;
        Write-Host "	 /////// 		" -f cyan -nonewline; Write-Host "$sunset		$windcondition" -f white;
        Write-Host ""
      }
    ELSEIF  ($lightSnow.Contains($data.weather.number))
      {
        Write-Host "	  .-.   		" -f gray -nonewline; Write-Host "$currenttemp		$humidity" -f white;
        Write-Host "	 (   ). 		" -f gray -nonewline; Write-Host "$high		$precipitation" -f white;
        Write-Host "	(___(__)		" -f gray -nonewline; Write-Host "$low		$precipitationData" -f white;
        Write-Host "	 *  *  *		$sunrise		$windspeed"
        Write-Host "	*  *  * 		$sunset		$windcondition"
        Write-Host ""
      }
    ELSEIF  ($heavySnow.Contains($data.weather.number))
      {
        Write-Host "	    .-.   		" -f gray -nonewline; Write-Host "$currenttemp		$humidity" -f white;
        Write-Host "	   (   ). 		" -f gray -nonewline; Write-Host "$high		$precipitation" -f white;
        Write-Host "	  (___(__)		" -f gray -nonewline; Write-Host "$low		$precipitationData" -f white;
        Write-Host "	  * * * * 		$sunrise		$windspeed"
        Write-Host "	 * * * *  		$sunset		$windcondition"
        Write-Host "	  * * * * "
        Write-Host ""
      }
    ELSEIF  ($snowAndRain.Contains($data.weather.number))
      {
        Write-Host "	  .-.   		" -f gray -nonewline; Write-Host "$currenttemp		$humidity" -f white;
        Write-Host "	 (   ). 		" -f gray -nonewline; Write-Host "$high		$precipitation" -f white;
        Write-Host "	(___(__)		" -f gray -nonewline; Write-Host "$low		$precipitationData" -f white;
        Write-Host "	 */ */* 		$sunrise		$windspeed"
        Write-Host "	* /* /* 		$sunset		$windcondition"
        Write-Host ""
      }
    ELSEIF  ($atmosphere.Contains($data.weather.number))
      {
        Write-Host "	_ - _ - _ -		" -f gray -nonewline; Write-Host "$currenttemp		$humidity" -f white;
        Write-Host "	 _ - _ - _ 		" -f gray -nonewline; Write-Host "$high		$precipitation" -f white;
        Write-Host "	_ - _ - _ -		" -f gray -nonewline; Write-Host "$low		$precipitationData" -f white;
        Write-Host "	 _ - _ - _ 		" -f gray -nonewline; Write-Host "$sunrise		$windspeed" -f white;
        Write-Host "				$sunset		$windcondition"
        Write-Host ""
      }
    <#	
      The following will be displayed on clear evening conditions
      It is set to 18:00:00 (6:00PM). Change this to any value you want.
    #>
    ELSEIF  ($clear.Contains($data.weather.number) -and $time -gt "18:00:00")
      {
        Write-Host "	    *  --.			$currenttemp		$humidity"
        Write-Host "	        \  \   *		$high		$precipitation"
        Write-Host "	         )  |    *		$low		$precipitationData"
        Write-Host "	*       <   |			$sunrise		$windspeed"
        Write-Host "	   *    ./ /	  		$sunset		$windcondition"
        Write-Host "	       ---'   *   "
        Write-Host ""
      }
    ELSEIF  ($clear.Contains($data.weather.number))
      {
        Write-Host "	   \ | /  		" -f Yellow -nonewline; Write-Host "$currenttemp		$humidity" -f white;
        Write-Host "	    .-.   		" -f Yellow -nonewline; Write-Host "$high		$precipitation" -f white;
        Write-Host "	-- (   ) --		" -f Yellow -nonewline; Write-Host "$low		$precipitationData" -f white;
        Write-Host "	    ``'``   		" -f Yellow -nonewline; Write-Host "$sunrise		$windspeed" -f white;
        Write-Host "	   / | \  		"-f yellow -nonewline; Write-Host "$sunset		$windcondition" -f white;
        Write-Host ""
      }
    ELSEIF ($partlyCloudy.Contains($data.weather.number))
      {
        Write-Host "	   \ | /   		" -f Yellow -nonewline; Write-Host "$currenttemp		$humidity" -f white;
        Write-Host "	    .-.    		" -f Yellow -nonewline; Write-Host "$high		$precipitation" -f white;
        Write-Host "	-- (  .--. 		$low		$precipitationData"  
        Write-Host "	   .-(    ). 		$sunrise		$windspeed" 
        Write-Host "	  (___.__)__)		$sunset		$windcondition"
        Write-Host ""
      }
    ELSEIF ($cloudy.Contains($data.weather.number))
      {
      Write-Host "	    .--.   		$currenttemp		$humidity"
      Write-Host "	 .-(    ). 		$high		$precipitation"
      Write-Host "	(___.__)__)		$low		$precipitationData"
      Write-Host "	            		$sunrise		$windspeed"
      Write-Host "				$sunset		$windcondition"
      Write-Host ""
      }
    ELSEIF ($windy.Contains($data.weather.number))
      {
      Write-Host "	~~~~      .--.   		$currenttemp		$humidity"
      Write-Host "	 ~~~~~ .-(    ). 		$high		$precipitation"
      Write-Host "	~~~~~ (___.__)__)		$low		$precipitationData"
      Write-Host "	                 		$sunrise		$windspeed"
      Write-Host "					$sunset		$windcondition"
      }
  }