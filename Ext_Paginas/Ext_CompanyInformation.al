pageextension 50101 "Company Details" extends "Company Information"
{
    layout
    {
        addbefore(Picture)
        {
            field("RUT Company"; Rec."Rut Company")
            {
                ApplicationArea = All;
                ToolTip = 'Ingresar Rut sin puntos y con guión';
                Caption = 'Rut empresa';
                NotBlank = true;
                ShowMandatory = true;
            }
            field("Comuna"; Rec.County)
            {
                ApplicationArea = All;
                ToolTip = 'Localización Chilena. Comuna';
                Caption = 'Comuna';
                trigger OnLookup(var Text: Text): Boolean
                var
                    ItemRec: Record "Post Code";
                begin
                    if Page.RunModal(Page::"Post Codes", ItemRec) = Action::LookupOK then
                        Rec.County := ItemRec.County;
                    Rec.City := ItemRec.City; // Actualiza Ciudad
                    Rec."Post Code" := ItemRec.Code; // Actualiza Código Postal
                end;

                trigger OnValidate()
                var
                    PostCodeRec: Record "Post Code";
                begin
                    if PostCodeRec.Get(Rec.County) then begin
                        Rec.City := PostCodeRec.City;
                        Rec."Post Code" := PostCodeRec.Code;
                    end else begin
                        Rec.City := '';
                        Rec."Post Code" := '';
                    end;
                end;
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