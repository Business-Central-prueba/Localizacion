
// Verificar bien si el ID no está utilizado por otra entidad

table 50162 CategoriaActividadEconomica
{
    DataClassification = ToBeClassified;
    //DrillDownPageId = "Categorias Act. Económicas";

    fields
    {

        field(3; codigo_Categoria; Code[150])
        {
            Caption = 'Código categoría';
            DataClassification = ToBeClassified;
        }

        field(2; nombreCategoria; Text[100])
        {
            Caption = 'Nombre Categoria';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; codigo_Categoria)
        {
            Clustered = true;
        }
    }

}