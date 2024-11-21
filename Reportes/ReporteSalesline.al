
report 50102 ReporteBalance8Columnas
{
    ApplicationArea = All;
    Caption = 'Balance de 8 Columnas';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Excel;
    ExcelLayout = './Reportes/ReporteBalance8Columnas.xlsx';
    dataset
    {
        dataitem(GenLedgerAccount; "G/L Account")
        {
            // Filtrar por rango de fechas
            //DataItemTableView = sorting("No.") where("Posting Date" = filter(FechaInicio..FechaFin));

            // Campos base
            column(No_; GenLedgerAccount."No.")
            {
                Caption = 'Código de cuenta';
            }
            column(Name; GenLedgerAccount."Name")
            {
                Caption = 'Nombre de la cuenta';
            }
            column(AccountType; GenLedgerAccount."Account Type")
            {
                Caption = 'Tipo de cuenta';
            }

            // Saldo inicial debe
            column(SaldoInicialDebe; CalcSaldoInicialDebe(GenLedgerAccount."No."))
            {
                Caption = 'Saldo Inicial Debe';
            }
            // Saldo inicial haber
            column(SaldoInicialHaber; CalcSaldoInicialHaber(GenLedgerAccount."No."))
            {
                Caption = 'Saldo Inicial Haber';
            }

            // Movimientos debe
            column(MovimientosDebe; CalcMovimientosDebe(GenLedgerAccount."No."))
            {
                Caption = 'Movimientos Debe';
            }
            // Movimientos haber
            column(MovimientosHaber; CalcMovimientosHaber(GenLedgerAccount."No."))
            {
                Caption = 'Movimientos Haber';
            }

            // Suma debe (saldo inicial debe + movimientos debe)
            column(SumaDebe; CalcSumaDebe(GenLedgerAccount."No."))
            {
                Caption = 'Suma Debe';
            }
            // Suma haber (saldo inicial haber + movimientos haber)
            column(SumaHaber; CalcSumaHaber(GenLedgerAccount."No."))
            {
                Caption = 'Suma Haber';
            }

            // Saldo debe
            column(SaldoDebe; CalcSaldoDebe(GenLedgerAccount."No."))
            {
                Caption = 'Saldo Debe';
            }
            // Saldo haber
            column(SaldoHaber; CalcSaldoHaber(GenLedgerAccount."No."))
            {
                Caption = 'Saldo Haber';
            }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                field(FechaInicio; FechaInicio)
                {
                    ApplicationArea = All;
                    Caption = 'Fecha Inicio';
                }
                field(FechaFin; FechaFin)
                {
                    ApplicationArea = All;
                    Caption = 'Fecha Fin';
                }
            }
        }
        actions
        {
            area(Processing)
            {
                // Acciones
            }
        }
    }

    trigger OnPreReport()
    begin
        if GenLedgerAccount.GetFilters = '' then
            Error('Por favor, aplique al menos un filtro antes de ejecutar el informe.');

        if not GenLedgerAccount.FindSet() then
            Error('No se encontraron datos que coincidan con los filtros aplicados.');
    end;

    // Variables para las fechas
    var
        FechaInicio: Date;
        FechaFin: Date;

    // Funciones para calcular las sumatorias y los saldos
    local procedure CalcSaldoInicialDebe(AccountNo: Code[20]): Decimal
    var
        GenLedgerEntry: Record "G/L Entry";
        Amount: Decimal;
    begin
        GenLedgerEntry.SetRange("G/L Account No.", AccountNo);
        GenLedgerEntry.SetRange("Posting Date", 20220101D, 20221231D); // Definir periodo según sea necesario
        //GenLedgerEntry.SetRange("Document Type", GenLedgerEntry."Document Type"::"Opening Balance");
        GenLedgerEntry.CalcSums(GenLedgerEntry.Amount);
        Amount := GenLedgerEntry.Amount;
        if Amount > 0 then
            exit(Amount)
        else
            exit(0);
    end;

    local procedure CalcSaldoInicialHaber(AccountNo: Code[20]): Decimal
    var
        GenLedgerEntry: Record "G/L Entry";
        Amount: Decimal;
    begin
        GenLedgerEntry.SetRange("G/L Account No.", AccountNo);
        GenLedgerEntry.SetRange("Posting Date", 20220101D, 20221231D); // Definir periodo según sea necesario
        //GenLedgerEntry.SetRange("Document Type", GenLedgerEntry."Document Type"::"Opening Balance");
        GenLedgerEntry.CalcSums(GenLedgerEntry.Amount);
        Amount := GenLedgerEntry.Amount;
        if Amount < 0 then
            exit(Abs(Amount))
        else
            exit(0);
    end;

    local procedure CalcMovimientosDebe(AccountNo: Code[20]): Decimal
    var
        GenLedgerEntry: Record "G/L Entry";
        Amount: Decimal;
    begin
        GenLedgerEntry.SetRange("G/L Account No.", AccountNo);
        GenLedgerEntry.SetRange("Posting Date", 20230101D, 20231231D); // Año actual o periodo a definir
        GenLedgerEntry.CalcSums(GenLedgerEntry.Amount);
        Amount := GenLedgerEntry.Amount;
        if Amount > 0 then
            exit(Amount)
        else
            exit(0);
    end;

    local procedure CalcMovimientosHaber(AccountNo: Code[20]): Decimal
    var
        GenLedgerEntry: Record "G/L Entry";
        Amount: Decimal;
    begin
        GenLedgerEntry.SetRange("G/L Account No.", AccountNo);
        GenLedgerEntry.SetRange("Posting Date", 20230101D, 20231231D); // Año actual o periodo a definir
        GenLedgerEntry.CalcSums(GenLedgerEntry.Amount);
        Amount := GenLedgerEntry.Amount;
        if Amount < 0 then
            exit(Abs(Amount))
        else
            exit(0);
    end;

    local procedure CalcSumaDebe(AccountNo: Code[20]): Decimal
    begin
        exit(CalcSaldoInicialDebe(AccountNo) + CalcMovimientosDebe(AccountNo));
    end;

    local procedure CalcSumaHaber(AccountNo: Code[20]): Decimal
    begin
        exit(CalcSaldoInicialHaber(AccountNo) + CalcMovimientosHaber(AccountNo));
    end;

    local procedure CalcSaldoDebe(AccountNo: Code[20]): Decimal
    begin
        // El saldo debe será la diferencia entre la suma de debe y haber
        exit(CalcSumaDebe(AccountNo) - CalcSumaHaber(AccountNo));
    end;

    local procedure CalcSaldoHaber(AccountNo: Code[20]): Decimal
    begin
        // El saldo haber será la diferencia entre la suma de haber y debe
        exit(CalcSumaHaber(AccountNo) - CalcSumaDebe(AccountNo));
    end;
}
