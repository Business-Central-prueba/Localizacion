page 50141 "API Config Lookup"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = "API Configuration";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Postman-Token"; Rec."Postman-Token")
                {
                    ApplicationArea = All;
                    Caption = 'Postman Token';
                    Editable = true;
                }
                field("Content-Type"; Rec."Content-Type")
                {
                    ApplicationArea = All;
                    Caption = 'Content Type';
                    Editable = true;
                }
                field("Content-Length"; Rec."Content-Length")
                {
                    ApplicationArea = All;
                    Caption = 'Content Length';
                    Editable = true;
                }
                field("Host"; Rec."Host")
                {
                    ApplicationArea = All;
                    Caption = 'Host';
                    Editable = true;
                }
                field("User-Agent"; Rec."User-Agent")
                {
                    ApplicationArea = All;
                    Caption = 'User Agent';
                    Editable = true;
                }
                field("Accept"; Rec."Accept")
                {
                    ApplicationArea = All;
                    Caption = 'Accept';
                    Editable = true;
                }
                field("Accept-Encoding"; Rec."Accept-Encoding")
                {
                    ApplicationArea = All;
                    Caption = 'Accept Encoding';
                    Editable = true;
                }
                field("Connection"; Rec."Connection")
                {
                    ApplicationArea = All;
                    Caption = 'Connection';
                    Editable = true;
                }
                field("apikey"; Rec."apikey")
                {
                    ApplicationArea = All;
                    Caption = 'API Key';
                    Editable = true;
                }
                field("Idempotency-Key"; Rec."Idempotency-Key")
                {
                    ApplicationArea = All;
                    Caption = 'Idempotency Key';
                    Editable = true;
                }
            }
        }
    }
}
