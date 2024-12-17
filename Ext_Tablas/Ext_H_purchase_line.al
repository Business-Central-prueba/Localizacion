tableextension 50987 Ext_T_P_Purchase extends "Purch. Inv. Line"
{
    fields
    {

        field(55100; "Retención + base"; integer)
        {
            Caption = 'N';
            DataClassification = ToBeClassified;
        }
        field(55101; "Retención"; integer)
        {
            Caption = 'N';
            DataClassification = ToBeClassified;

        }
        field(55102; "Monto Liquido"; integer)
        {
            Caption = 'Localización Chilena. Monto líquido para boleta de honorarios.';
            DataClassification = ToBeClassified;

        }

        field(55103; "Retención %"; Decimal)
        {
            Caption = 'Localización Chilena. Porcentaje de retención.';
            DecimalPlaces = 0 : 5;
            DataClassification = ToBeClassified;

        }

    }
}
