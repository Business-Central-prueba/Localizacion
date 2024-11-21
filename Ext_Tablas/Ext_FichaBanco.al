tableextension 50131 "TE_Extension Ficha Venta" extends "Bank Account"
{
    fields
    {
        field(59999; BancoChile; Code[60])
        {
            Caption = 'Bancos de Chile';
            TableRelation = Bancos;
            DataClassification = ToBeClassified;
        }
    }
}