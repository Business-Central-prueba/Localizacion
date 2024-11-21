pageextension 50101 "Company Details" extends "Company Information"
{
    layout
    {
        addlast(General)
        {
            field("RUT Company"; Rec."Rut Company")
            {
                ApplicationArea = All;
                ToolTip = 'Ingresar Rut sin puntos y con Guión';
                Caption = 'Rut Company';
            }
            field("Comuna"; Rec.County)
            {
                ApplicationArea = All;
                ToolTip = 'County';
                Caption = 'County';
            }
            field(codigoActividad; Rec.codigoActividad)
            {
                ApplicationArea = All;
                ToolTip = 'Localización Chilena. Actividad económica';
                Caption = 'Actividad económica';
                trigger OnLookup(var Text: Text): Boolean
                var
                    ItemRec: Record actividadEconomica;
                begin
                    ItemRec.Reset();
                    if Page.RunModal(Page::"Actividades Económicas", ItemRec) = Action::LookupOK then
                        Rec.codigoActividad := ItemRec.nombre_Actividad;
                end;
            }
        }
    }
}