page 50109 api_vat_business_post_group
{
    APIGroup = 'Localizacion';
    APIPublisher = 'KIS';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'apiVatBusinessPostGroup';
    DelayedInsert = true;
    EntityName = 'VATBusinessPostingGroup';
    EntitySetName = 'VATBusinessPostingGroup';
    PageType = API;
    SourceTable = "VAT Business Posting Group";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(lastModifiedDateTime; Rec."Last Modified Date Time")
                {
                    Caption = 'Last Modified Date Time';
                }
            }
        }
    }
}
