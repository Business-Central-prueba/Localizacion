pageextension 50131 "Ext. Ficha Banco" extends "Bank Account Card"
{
    layout
    {
        addlast(General)
        {
            field(BancoChile; Rec.BancoChile)
            {
                ApplicationArea = All;
                ToolTip = 'Localización Chilena. Bancos de Chile.';
                trigger OnLookup(var Text: Text): Boolean
                var
                    ItemRec: Record Bancos;
                begin
                    ItemRec.Reset();
                    if Page.RunModal(Page::"Bancos Chile", ItemRec) = Action::LookupOK then
                        Rec.BancoChile := ItemRec.nombreBanco;
                end;
            }
        }
    }
}