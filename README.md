# Misc M365 BEC Resources

This is just a compilation of M365 "business email compromise" (BEC) investigative tools, notes, etc. M365 is in "constant development," so things change rapidly and, as usual, I'm a fan of simple, lightweight "tools" (scripts, whatever) that help me (you!) quickly, accessibly (meaning it's important we undertsand what any "tool" is doing!) answer investigative questions!

## Unified Audit Log (UAL) Export in JSON for SOF-ELK
It's no secret that I'm a huge fan of [SOF-ELK](https://github.com/philhagen/sof-elk). Pulling the UAL can be finicky and there are many, many complicated scripts that help with this! But...I like mine, because it's simple! I usually want to investigate a single user during a specific period of time, and the [ual-export-for-sof-elk](https://github.com/secure-cake/m365-bec-resources/blob/main/ual-export-for-sof-elk)  does precisely that, outputing results into a single JSON file for ingestion into SOF-ELK. You can also use it to export all users but again, I like "targeted," finite queries as much as possible. 

## M365 Permissions
Yeah...this has probably changed since I finished typing it, but hopefully still a useful guide! You can, of course, just use "Global Admin" but that's not very "least privilege" of you! Minimally, step through the following to create an investigative account and grant "read only" access to the data via PowerShell (or the admin UI): 

Log into the [M365 Admin Portal](https://admin.microsoft.com) or go to directly to [“Add User”](https://admin.microsoft.com/#/users/:/adduser).

Click on “Users\Active Users” from left-hand menu, then click “Add a user” from top menu. 

Enter First and Last Name, Display Name, Username and select appropriate Domain. Set a password as desired, and check “Require this user to change their password when they first sign in,” then click Next. 

Select "Create user without a product license" (the investigative account does NOT need a license). 

Expand “Roles” and select “Global Reader,” then click Next, Finish Adding, and Close. Then expand “Roles” on left-hand menu, click “Role Assignments,” click “Exchange” on top menu and “Add role group.”

Input a name for the role group, eg “Exchange Auditing,” then click Next.

Type the name of the investigative User account in the “Members” box, then select the account name, click Next, Add Role Group, and Done.

NOTE: This may cause a low-severity alert for “Elevation of Exchange Admin Privileges,” which can be ignored for this specific alert instance. 
