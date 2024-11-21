
// Verificar bien si el ID no está utilizado por otra entidad

table 50160 actividadEconomica
{
    DataClassification = ToBeClassified;
    //DrillDownPageId = "Actividades Económicas";
    fields
    {
        field(1; codigoActividad; Code[150])
        {
            Caption = 'Codigo';
            DataClassification = ToBeClassified;
        }

        field(7; nombre_Actividad; Text[500])
        {
            Caption = 'Nombre actividad';
            DataClassification = ToBeClassified;
        }

        field(5; Categoria_Economica; Code[150])
        {
            Caption = 'Categoría actividad económica';
            DataClassification = ToBeClassified;
            TableRelation = CategoriaActividadEconomica;
        }

        field(6; Subcategoria_Economica; Code[150])
        {
            Caption = 'Subcategoría actividad económica';
            DataClassification = ToBeClassified;
            TableRelation = SubCategoriaActividad;
        }
    }
}