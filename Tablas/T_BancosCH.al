
// Verificar bien si el ID no está utilizado por otra entidad

table 50166 Bancos
{
    DataClassification = ToBeClassified;
    //DrillDownPageId = "Bancos Chile";

    fields
    {
        field(1; codigoBanco; Code[10])
        {
            Caption = 'Codigo Banco';
            DataClassification = ToBeClassified;

        }

        field(2; nombreBanco; Text[100])
        {
            Caption = 'Nombre Banco';
            DataClassification = ToBeClassified;
        }

        field(5; Opcion_Tipo_Banco; Code[20])
        {
            Caption = 'Tipo de banco';
            DataClassification = ToBeClassified;
            TableRelation = tipoBanco;
        }

    }

    keys
    {
        key(Key1; codigoBanco)
        {
            Clustered = true;
        }
    }


}