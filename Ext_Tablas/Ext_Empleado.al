// Verificar bien si el ID no está utilizado por otra entidad
tableextension 50129 "Rut Empleado" extends Employee
{
    fields
    {
        field(50703; RUT; Integer)
        {
            Caption = 'Localización Chile. RUT del empleado';
            DataClassification = ToBeClassified;
            NotBlank = true;
            trigger OnValidate()
            var
                ValidarRUT: Codeunit ValidarDigitoVerificador;
            begin
                ValidarRUT.VerificarRUT(RUT);
                Rec.DV := ValidarRUT.CalcularDigitoVerificador(RUT);
            end;
        }

        field(50699; DV; Code[1])
        {
            Caption = 'Localización Chile. Dígito verificador';
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            var
                ValidarRut: Codeunit ValidarDigitoVerificador;
            begin
                ValidarRUT.VerificarRUT(Rec.RUT);
                if (DV <> ValidarRUT.CalcularDigitoVerificador(Rec.RUT)) then Error('El dígito verificador ingresado es inválido.');
            end;
        }

    }
}