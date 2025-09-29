## M365 BEC Webcast - CTF Challenge

You’ve been asked to investigate an Entra ID alert regarding unusual authentication to M365 from Larry James’ account (ljames @ interlink-tech.com) and provided with a Unified Audit Log (UAL) CSV export from Purview for your analysis. 

[UAL Export File](https://securecake.nyc3.cdn.digitaloceanspaces.com/m365_bec_webcast/CTF-Purview-Audit-LJames-08052024-08092024.csv)

Based on business email compromise (BEC) standard operating procedures (SOP), investigate the following: 
-	Attempts to hide email conversations via unauthorized inbox rule creation
-	Unauthorized application registration
-	Changes to user authentication

Answer the following questions: <br />

1.	What is the name of the malicious inbox rule?
2.	What is the name of the unauthorized application registration? 
3.	What is the value of the unauthorized authentication change for this user?

NOTE: Answer format = just the name (alphanumeric string)

---------------
### Writeup and Solutions

Question #1: What is the name of the malicious inbox rule?
-  You can search for the Operation "New-InboxRule," then look for the "Name":"Name" key-value pair
-  The Inbox rule name is "." (the value is in quotes, so the name is just a period)
<img width="1272" height="126" alt="image" src="https://github.com/user-attachments/assets/4b385290-b9b4-4b1e-b168-55478eb2c618" />

Question #2: What is the name of the unauthorized application registration?
-  You can search for "Add service principal," then look for the "DisplayName:","NewValue"
-  The name of the unauthorized application is "BlueMail"
<img width="956" height="124" alt="image" src="https://github.com/user-attachments/assets/0765f8b8-826e-4f65-be4f-c187b4d3824d" />

Question #3: What is the value of the unauthorized authentication change for this user?
-  You can search for the operation "update user," then look for the "Name:StrongAuthenticationUserDetails" and the following "NewValue" entry
-  New value is "PhoneNumber," and the value is "8655550426"
<img width="950" height="124" alt="image" src="https://github.com/user-attachments/assets/14268160-aefa-4cab-8770-0c73a57a9643" />

Question #4: What is the doppelganger domain used to impersonate the vendor?
-  If you take a look at the answer to #1, you'll get a clue about what domain the threat actor is interested in!
-  You can search for the domain or email address based on the inbox rule, look at email subjects, then search out that subject line.
-  Finally, stare at the mail entries with the subject line and see if you can identify the doppelganger!
-  The answer is "tlpprojectmgmt.com" (the legit domain is TPLprojectmgmt.com)
<img width="1352" height="110" alt="image" src="https://github.com/user-attachments/assets/a974c2a2-4e4f-4f85-abab-6120ed74d301" />
