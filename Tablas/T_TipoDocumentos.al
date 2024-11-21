
// Verificar bien si el ID no está utilizado por otra entidad

table 50169 tipoDocumentos
{

    DataClassification = ToBeClassified;
    //DrillDownPageId = "Tipos Documentos";
    fields
    {
        field(1; DTE; Code[50])
        {
            Caption = 'DTE';
            DataClassification = ToBeClassified;
        }


        field(3; Tipo; Text[256])
        {
            Caption = 'Tipo';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; DTE)
        {
            Clustered = true;
        }
    }

}