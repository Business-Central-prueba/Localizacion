page 50106 api_items
{
    APIGroup = 'Localizacion';
    APIPublisher = 'KIS';
    APIVersion = 'v2.0';
    Caption = 'apiItems';
    DelayedInsert = true;
    EntityName = 'items';
    EntitySetName = 'items';
    PageType = API;
    SourceTable = Item;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(allowInvoiceDisc; Rec."Allow Invoice Disc.")
                {
                    Caption = 'Allow Invoice Disc.';
                }
                field(allowOnlineAdjustment; Rec."Allow Online Adjustment")
                {
                    Caption = 'Allow Online Adjustment';
                }
                field(alternativeItemNo; Rec."Alternative Item No.")
                {
                    Caption = 'Alternative Item No.';
                }
                field(applicationWkshUserID; Rec."Application Wksh. User ID")
                {
                    Caption = 'Application Wksh. User ID';
                }
            }
        }
    }
}
