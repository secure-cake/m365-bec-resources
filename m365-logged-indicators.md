## M365 Logged Indicators
This is a running list of what I hope will provide "actionable intelligence," discrete entries you can search for or, even better, alert on to detect EVIL!

**Indicator: User MFA Settings Changes<br />**
Log Source: Entra ID Audit Logs<br />
Key: 'Update User'<br />
Value: StrongAuthenticationUserDetails<br />
Review: 'NewValue'<br />
NOTES: Often an added MFA option, e.g. adding a Phone Number for SMS auth<br />

**Indicator: New Service Principal (see also App Registration below)<br />**
Log Source: Entra ID Audit Logs<br />
Key: 'Add Service Principal'<br />
Value: DisplayName<br />
Review: 'NewValue'<br />
NOTES: Often an unauhtorized app for mailbox sync or searching M365 content<br />

**Indicator: New App Registration (see also New Service Principal above)<br />**
Log Source: Entra ID Audit Logs<br />
Key: 'Add App Role Assignment Grant to User'<br />
Value: ServicePrincipal<br />
Review: 'ID'<br />
NOTES: Often an unauhtorized app for mailbox sync or searching M365 content<br />

**Indicator: New Inbox Rule<br />**
Log Source: M365 UAL<br />
Key: 'New-InboxRule'<br />
Value: Name<br />
Review: FromAddressContainsWords<br />
NOTES: Often used to hide inbound content from the actual User<br />
