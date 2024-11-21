table 50165 SubCategoriaActividad
{
    DataClassification = ToBeClassified;
    //DrillDownPageId = "Subcategoría act. económicas";

    fields
    {
        field(5; codigo_Subcategoria; Code[150])
        {
            Caption = 'Código Subcategoría';
            DataClassification = ToBeClassified;
        }

        field(3; nombreSubCategorias; Text[100])
        {
            Caption = 'Nombre Sub Categoria';
            DataClassification = ToBeClassified;
        }

        field(6; Codigo_Categoria; Code[150])
        {
            Caption = 'Código categoría';
            DataClassification = ToBeClassified;
            TableRelation = CategoriaActividadEconomica;
        }
    }


    keys
    {
        key(Key1; codigo_Subcategoria)
        {
            Clustered = true;
        }
    }
}