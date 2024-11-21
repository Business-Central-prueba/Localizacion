page 50103 api_usuarios
{
    APIGroup = 'Localizacion';
    APIPublisher = 'KIS';
    APIVersion = 'v2.0';
    Caption = 'apiUsuarios';
    DelayedInsert = true;
    EntityName = 'User';
    EntitySetName = 'User';
    PageType = API;
    SourceTable = User;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(userName; Rec."User Name")
                {
                    Caption = 'User Name';
                }
                // field(applicationID; Rec."Application ID")
                // {
                //     Caption = 'Application ID';
                // }
                // field(authenticationEmail; Rec."Authentication Email")
                // {
                //     Caption = 'Authentication Email';
                // }
                // field(changePassword; Rec."Change Password")
                // {
                //     Caption = 'Change Password';
                // }
                field(contactEmail; Rec."Contact Email")
                {
                    Caption = 'Contact Email';
                }
                // field(exchangeIdentifier; Rec."Exchange Identifier")
                // {
                //     Caption = 'Exchange Identifier';
                // }
                // field(expiryDate; Rec."Expiry Date")
                // {
                //     Caption = 'Expiry Date';
                // }
                // field(fullName; Rec."Full Name")
                // {
                //     Caption = 'Full Name';
                // }
                // field(licenseType; Rec."License Type")
                // {
                //     Caption = 'License Type';
                // }
                // field(state; Rec.State)
                // {
                //     Caption = 'State';
                // }
                // field(systemCreatedAt; Rec.SystemCreatedAt)
                // {
                //     Caption = 'SystemCreatedAt';
                // }
                // field(systemCreatedBy; Rec.SystemCreatedBy)
                // {
                //     Caption = 'SystemCreatedBy';
                // }
                // field(systemId; Rec.SystemId)
                // {
                //     Caption = 'SystemId';
                // }
                // field(systemModifiedAt; Rec.SystemModifiedAt)
                // {
                //     Caption = 'SystemModifiedAt';
                // }
                // field(systemModifiedBy; Rec.SystemModifiedBy)
                // {
                //     Caption = 'SystemModifiedBy';
                // }
                // field(userSecurityID; Rec."User Security ID")
                // {
                //     Caption = 'User Security ID';
                // }
                // field(windowsSecurityID; Rec."Windows Security ID")
                // {
                //     Caption = 'Windows Security ID';
                // }
            }
        }
    }
}
