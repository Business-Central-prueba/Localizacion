table 50133 Opci
//Esta tabla es creada para mostrar en pantalla las distintas tablas existentes. Muestra en page de importar/exportar XML
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; Opciones; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Escoger tabla';
            OptionMembers = ,Proveedor,Cliente,Empleados,"Categorias económicas","Subcategoria económica","Actividades económica","Código postal","Tipo de documento","Tipo de transacción","Tipo de banco",Banco;
            trigger OnValidate()
            begin

                if Opciones = Opciones::Cliente then
                    ValorSeleccionado := 1;

                if Opciones = Opciones::Proveedor then
                    ValorSeleccionado := 2;

                if Opciones = Opciones::"Categorias económicas" then
                    ValorSeleccionado := 3;

                if Opciones = Opciones::"Subcategoria económica" then
                    ValorSeleccionado := 4;

                if Opciones = Opciones::"Actividades económica" then
                    ValorSeleccionado := 5;

                if Opciones = Opciones::Banco then
                    ValorSeleccionado := 6;

                if Opciones = Opciones::"Tipo de banco" then
                    ValorSeleccionado := 7;

                if Opciones = Opciones::"Tipo de documento" then
                    ValorSeleccionado := 8;

                if Opciones = Opciones::"Tipo de transacción" then
                    ValorSeleccionado := 9;

                if Opciones = Opciones::"Código postal" then
                    ValorSeleccionado := 10;

                if Opciones = Opciones::Empleados then
                    ValorSeleccionado := 11;

            end;
        }

        field(2; ValorSeleccionado; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Valor seleccionado';
            InitValue = 0;

        }

    }
}