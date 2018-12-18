 # microsoft-graph-tools
This set of tools allows for interaction with the Microsoft Azure Graph API. The use case in which this tool was developed was to extract mail addresses from an Azure Active Directory.

## Getting started
It is assumed you already have an Azure Portal account and active Azure Active Directory.

### Dependencies
```apt install curl jq```

### Getting credentials
* Log into your [Microsoft Azure Portal](https://portal.azure.com/) and open the Settings for your Azure Active Directory.
* Open App Registrations and click *New Application Registration*
  * Name it any way you like.
  * The sign in URL needs to respond to your backend. You can change this later if you don't know the value yet. You can enter `https://localhost` as a placeholder.
  * After creating the Application Registration, save the Application ID in the overview. This is your `clientID`.
  * Open the Settings for your new application.
  * Open *Required Permissions*
    * Click *Add*, select the Microsoft Graph API.
    * At least assign the following privileges (or all of them): 
      * Application Permissions: *Read all user mailbox settings* (`MailboxSettings.Read`)
      * Application Permissions: *Read all users' full profiles* (`User.Read.All`)
    * Save the settings, then click 'Grant Permissions' in the list of applications. This is important.
  * Open *Keys* and add a new password. Copy and keep the value - you won't be able to display it again. This password is your `clientSecret`.

### Filling the config
* Create a copy of the `config.json` template: `cp config.json.tpl config.json`
* Open the copy in an editor of your choice and fill out the `tenant`, `clientID` and `clientSecret` field with the data you gathered in the previous step. The tenant is likely your mail domain (*something.onmicrosoft.com* or your own domain).

### Getting your auth token
The Azure API works through a JWT-based authentication token. After filling out the config, the `get-auth-token.sh` script can generate a token for you. It will write it to the `authtoken` file and display the JSON payload contained within it.

```$ ./get-auth-token.sh
{
  "aud": "https://graph.microsoft.com",
  "iss": "https://sts.windows.net/e2ce638e-b657-4067-8529-ed24f601cb00/",
  "iat": xxxxxxxxxx,
  "nbf": xxxxxxxxxx,
  "exp": xxxxxxxxxx,
  "aio": "xxxxxxxxxxxxxxxxxxxxxxxxxx,
  "app_displayname": "mytestapp",
  "appid": "83f676c6-c3a9-46e1-aed4-22ffa750e6c1",
  "appidacr": "1",
  "idp": "https://sts.windows.net/83f676c6-c3a9-46e1-aed4-22ffa750e6c1/",
  "oid": "c5f23c35-6ec4-4b79-a321-62445b513817",
  "roles": [
    "MailboxSettings.Read",
    "User.Read.All"
  ],
  "sub": "3bc6f878-43f5-47f9-b32b-1847cb6cb761",
  "tid": "23a58f33-1134-4f48-8a19-8a0719ea9c7d",
  "uti": "xxxxxxxxxxxxxxxxxxxxxxxxxx",
  "ver": "1.0",
  "xms_tcdt": xxxxxxxxxxxxxxxxxxxxxxxxxx
}
```

### Making requests
The `REQ-endpoint.sh` allows you to query arbitrary endpoints, e.g.:
```
$ ./REQ-endpoint.sh /users/xxxxxxxxxxxxxxxxxxxxx@yourdomain.onmicrosoft.com
{
  "@odata.context": "https://graph.microsoft.com/beta/$metadata#users/$entity",
  "id": "xxxxxxxxxxxxxxxxxxxxx",
  "deletedDateTime": null,
  "accountEnabled": true,
  "ageGroup": null,
  "businessPhones": [],
  "city": null,
  "createdDateTime": null,
  "companyName": null,
  "consentProvidedForMinor": null,
  "country": null,
  "department": "xxxxxxxxxxxxxxxxxxxxx",
  "displayName": "xxxxxxxxxxxxxxxxxxxxx",
  "employeeId": null,
  "faxNumber": null,
  "givenName": "xxxxxxxxxxxxxxxxxxxxx",
  "imAddresses": [
    "xxxxxxxxxxxxxxxxxxxxx@yourdomain.onmicrosoft.com"
  ],
  "isResourceAccount": null,
  "jobTitle": "xxxxxxxxxxxxxxxxxxxxx",
  "legalAgeGroupClassification": null,
  "mail": "xxxxxxxxxxxxxxxxxxxxx@yourdomain.onmicrosoft.com",
  "mailNickname": "xxxxxxxxxxxxxxxxxxxxx",
  "mobilePhone": null,
  "onPremisesDistinguishedName": null,
  "officeLocation": null,
  "onPremisesDomainName": null,
  "onPremisesImmutableId": null,
  "onPremisesLastSyncDateTime": null,
  "onPremisesSecurityIdentifier": null,
  "onPremisesSamAccountName": null,
  "onPremisesSyncEnabled": null,
  "onPremisesUserPrincipalName": null,
  "otherMails": [],
  "passwordPolicies": "None",
  "passwordProfile": null,
  "postalCode": null,
  "preferredDataLocation": null,
  "preferredLanguage": "de-DE",
  "proxyAddresses": [
    "smtp:xxxxxxxxxxxxxxxxxxxxx@yourdomain.onmicrosoft.com",
    "SMTP:xxxxxxxxxxxxxxxxxxxxx@yourdomain.onmicrosoft.com"
  ],
  "refreshTokensValidFromDateTime": "2018-12-17T12:04:19Z",
  "showInAddressList": null,
  "state": null,
  "streetAddress": null,
  "surname": "Duerrwanger",
  "usageLocation": "DE",
  "userPrincipalName": "xxxxxxxxxxxxxxxxxxxxx@yourdomain.onmicrosoft.com",
  "externalUserState": null,
  "externalUserStateChangeDateTime": null,
  "userType": "Member",
  "assignedLicenses": [],
  "assignedPlans": [],
  "deviceKeys": [],
}
```
