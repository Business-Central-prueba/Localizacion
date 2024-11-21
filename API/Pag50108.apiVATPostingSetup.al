page 50108 api_VAT_Posting_Setup
{
    APIGroup = 'LOCALIZACION';
    APIPublisher = 'KIS';
    APIVersion = 'v2.0';
    Caption = 'apiVATPostingSetup';
    DelayedInsert = true;
    EntityName = 'VAT_Posting_Setup';
    EntitySetName = 'VAT_Posting_Setup';
    PageType = API;
    SourceTable = "VAT Posting Setup";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(salesVATAccount; Rec."Sales VAT Account")
                {
                    Caption = 'Sales VAT Account';
                }
                field(purchaseVATAccount; Rec."Purchase VAT Account")
                {
                    Caption = 'Purchase VAT Account';
                }
                field(vat; Rec."VAT %")
                {
                    Caption = 'VAT %';
                }
                field(vatCalculationType; Rec."VAT Calculation Type")
                {
                    Caption = 'VAT Calculation Type';
                }
                field(vatBusPostingGroup; Rec."VAT Bus. Posting Group")
                {
                    Caption = 'VAT Bus. Posting Group';
                }
                field(vatClauseCode; Rec."VAT Clause Code")
                {
                    Caption = 'VAT Clause Code';
                }
                field(vatIdentifier; Rec."VAT Identifier")
                {
                    Caption = 'VAT Identifier';
                }
                field(vatProdPostingGroup; Rec."VAT Prod. Posting Group")
                {
                    Caption = 'VAT Prod. Posting Group';
                }
                field(taxCategory; Rec."Tax Category")
                {
                    Caption = 'Tax Category';
                }
                field(unrealizedVATType; Rec."Unrealized VAT Type")
                {
                    Caption = 'Unrealized VAT Type';
                }
            }
        }
    }
}
