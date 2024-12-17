pageextension 50105 Ext_CuentaAsignacionDistr extends "Fixed Account Distribution"
{
    layout
    {
        addbefore(Percent)
        {
            field("esRetencion"; Rec.esBoletaHonorario)
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin

                    CurrPage.UPDATE(true);
                end;
            }
        }
    }
}
