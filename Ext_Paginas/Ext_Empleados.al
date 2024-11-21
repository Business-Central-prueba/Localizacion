pageextension 50129 "Page Ext. Rut Empelado" extends "Employee Card"
{
    layout
    {
        addfirst(General)
        {
            field(RUT; Rec.RUT)
            {
                ApplicationArea = All;
                ToolTip = 'Localización Chilena. RUT del empleado';
                Caption = 'RUT';
            }

            field(DV; Rec.DV)
            {
                ToolTip = 'Localización Chilena. Dígito verificador';
                Caption = 'Dígito verificador';
                ApplicationArea = All;

            }
        }
    }

    actions
    {

    }

}