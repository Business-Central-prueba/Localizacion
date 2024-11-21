page 50129 "API Configuration Page"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "API Configuration";
    UsageCategory = Administration;
    CardPageId = "API Configuration Page";

    layout
    {
        area(content)
        {
            group("Datos de configuración")
            {
                field("Postman-Token"; Rec."Postman-Token")
                {
                    ApplicationArea = All;
                    Editable = true;

                }
                field("Content-Type"; Rec."Content-Type")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Content-Length"; Rec."Content-Length")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Host"; Rec."Host")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("User-Agent"; Rec."User-Agent")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Accept"; Rec."Accept")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Accept-Encoding"; Rec."Accept-Encoding")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Connection"; Rec."Connection")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("apikey"; Rec."apikey")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Idempotency-Key"; Rec."Idempotency-Key")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Save)
            {
                ApplicationArea = All;
                Caption = 'Save';
                trigger OnAction()
                begin
                    Rec.Modify(); // Save changes
                    Commit(); // Commit transaction
                    Message('Changes saved successfully.');
                end;
            }
        }
    }
}
