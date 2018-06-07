<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2016 v5.2.109
	 Created on:   	2/17/2016 11:17 AM	
	 Organization: 	SAPIEN Technologies, Inc.
	 Filename:     	Network Computers.ps1
	===========================================================================
	.DESCRIPTION
		Save the network computer names for custom PrimalSense.
#>


#(Get-ADComputer -Filter *).name
Add-Type -ReferencedAssemblies ('System.Windows.Forms') -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
using System.Security;
using System.Collections;
using System.Windows.Forms;
using System.Collections.Specialized;
using System.Collections.Generic;

namespace SAPIEN
{
    public sealed class NetworkBrowser
    {
        [DllImport("Netapi32", CharSet = CharSet.Auto, SetLastError = true),
        SuppressUnmanagedCodeSecurityAttribute]

        public static extern int NetServerEnum(
            string ServerNane, // must be null
            int dwLevel,
            ref IntPtr pBuf,
            int dwPrefMaxLen,
            out int dwEntriesRead,
            out int dwTotalEntries,
            int dwServerType,
            string domain, // null for login domain
            out int dwResumeHandle
            );

        [DllImport("Netapi32", SetLastError = true),
        SuppressUnmanagedCodeSecurityAttribute]

        public static extern int NetApiBufferFree(
            IntPtr pBuf);

        //create a _SERVER_INFO_100 STRUCTURE
        [StructLayout(LayoutKind.Sequential)]
        public struct _SERVER_INFO_100
        {
            internal int sv100_platform_id;
            [MarshalAs(UnmanagedType.LPWStr)]
            internal string sv100_name;
        }
     
        public NetworkBrowser()
        {

        }
           
        public string[] getNetworkComputers()
        {
            //local fields
            List<string> networkComputers = new List<string>();
            const int MAX_PREFERRED_LENGTH = -1;
            int SV_TYPE_WORKSTATION = 1;
            int SV_TYPE_SERVER = 2;
            IntPtr buffer = IntPtr.Zero;
            IntPtr tmpBuffer = IntPtr.Zero;
            int entriesRead = 0;
            int totalEntries = 0;
            int resHandle = 0;
            int sizeofINFO = Marshal.SizeOf(typeof(_SERVER_INFO_100));


            try
            {
                //call the DllImport : NetServerEnum with all its required parameters
                //see http://msdn.microsoft.com/library/default.asp?url=/library/en-us/netmgmt/netmgmt/netserverenum.asp
                //for full details of method signature
                int ret = NetServerEnum(null, 100, ref buffer, MAX_PREFERRED_LENGTH,
                    out entriesRead,
                    out totalEntries, SV_TYPE_WORKSTATION | SV_TYPE_SERVER, null, out 
					resHandle);
                //if the returned with a NERR_Success (C++ term), =0 for C#
                if (ret == 0)
                {
                    //loop through all SV_TYPE_WORKSTATION and SV_TYPE_SERVER PC's
                    for (int i = 0; i < totalEntries; i++)
                    {     
                        tmpBuffer = new IntPtr((int)buffer + (i * sizeofINFO));
                        _SERVER_INFO_100 svrInfo = (_SERVER_INFO_100)
                            Marshal.PtrToStructure(tmpBuffer, typeof(_SERVER_INFO_100));

                        //add the PC names to the ArrayList
                        networkComputers.Add(svrInfo.sv100_name);
                    }
                }
            }
            catch (Exception ex)
            {
                Console.Error.WriteLine("Error occurred while accessing network computers:\r\n" + ex.Message);
                return null;
            }
            finally
            {
                NetApiBufferFree(buffer);
            }
            //return entries found
            return networkComputers.ToArray();

        }
    }
}
"@
$networkBrowser = New-Object SAPIEN.NetworkBrowser
$networkBrowser.getNetworkComputers() > "$CustomSensePath\Network Computers.csv"