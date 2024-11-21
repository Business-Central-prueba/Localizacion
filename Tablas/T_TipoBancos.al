
// Verificar bien si el ID no está utilizado por otra entidad

table 50161 tipoBanco
{
    DataClassification = ToBeClassified;
    //DrillDownPageId = "Tipos de Banco";
    fields
    {

        field(4; Codigo_Tipo_Banco; Code[150])
        {
            DataClassification = ToBeClassified;
            Caption = 'Código tipo banco';
        }

        field(2; nombreBanco; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Nombre Tipo Banco';
        }

        field(3; descripcionTipoBanco; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Descripcion Tipo Banco';
        }

    }

    keys
    {
        key(Key1; Codigo_Tipo_Banco)
        {
            Clustered = true;
        }
    }

}