page 50200 "P_FactboxFactura"
{
    Caption = 'Item Details';
    PageType = CardPart;
    SourceTable = "Sales Line";


    layout
    {
        area(Content)
        {
            field(ItemNo; ShowNo)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Item No.';
                Lookup = false;
                ToolTip = 'Specifies the item that is handled on the sales line.';
            }
            field(Desc; rec.Description)
            {

            }
            field("Unit Price"; rec."Unit Price")
            {

            }
        }
    }

    local procedure ShowNo(): Code[20]
    begin
        if rec.Type <> rec.Type::Item then
            exit('');
        exit(rec."No.");
    end;
}