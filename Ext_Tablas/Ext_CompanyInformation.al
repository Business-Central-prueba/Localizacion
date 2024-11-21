tableextension 50101 "Company Information" extends "Company Information"
{
    fields
    {
        field(50100; "Rut Company"; Text[200])
        {
            Caption = 'Rut Company';
            DataClassification = ToBeClassified;
            Description = 'Ingresar rut sin puntos y con guion';
        }
        field(50780; codigoActividad; Code[250])
        {
            Caption = 'Actividad Economica';
            DataClassification = ToBeClassified;
            TableRelation = actividadEconomica;
        }

    }

}
