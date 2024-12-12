tableextension 50321 Ext_T_Purchase extends "Purchase Line"
{
    fields
    {

        field(55100; "Retención + base"; integer)
        {
            Caption = 'N';
        }
        field(55101; "Retención"; integer)
        {
            Caption = 'N';

        }
        field(55102; "Monto Liquido"; integer)
        {
            Caption = 'Monto Liquido';

        }

    }
}
