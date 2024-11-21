codeunit 50101 InstalacionAplicacion
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    var
        CategoriaActividadEconomica: Record CategoriaActividadEconomica;
        SubcategoriaEconomica: Record SubCategoriaActividad;
        ActividadEconomica: Record actividadEconomica;
        TipoDeDocumento: Record tipoDocumentos;
        TipoDeTransaccion: Record tipoTransaccion;
        BancosChile: Record Bancos;
        TipoBancos: Record tipoBanco;
        CodigoPostal: Record "Post Code";
        RetornoCodigoPostal: Boolean;

        Modulo: ModuleInfo;
    begin
        //---------------------Checar si existen datos dentro de la tabla, de lo contrario, los llena.
        if CategoriaActividadEconomica.IsEmpty then begin
            LlenadodeTablasCategoriaEconomica();
        end
        else begin
            CategoriaActividadEconomica.DeleteAll();
            LlenadodeTablasCategoriaEconomica();
        end;

        if SubcategoriaEconomica.IsEmpty then begin
            LlenadodeTablasSubcategoriaEconomica()
        end
        else begin
            SubcategoriaEconomica.DeleteAll();
            LlenadodeTablasSubcategoriaEconomica();
        end;

        if ActividadEconomica.IsEmpty then begin
            LlenadodeTablasActividadEconomica()
        end
        else begin
            ActividadEconomica.DeleteAll();
            LlenadodeTablasActividadEconomica();
        end;

        if TipoDeDocumento.IsEmpty then begin
            LlenadoDeTablaTipoDocumentos();
        end
        else begin
            TipoDeDocumento.DeleteAll();
            LlenadoDeTablaTipoDocumentos();
        end;

        if TipoDeTransaccion.IsEmpty then begin
            LlenadoDeTablaTipoTransaccion();
        end
        else begin
            TipoDeTransaccion.DeleteAll();
            LlenadoDeTablaTipoTransaccion();
        end;

        if BancosChile.IsEmpty then begin
            LlenadoDeTablaBanco();
        end
        else begin
            BancosChile.DeleteAll();
            LlenadoDeTablaBanco();
        end;

        if TipoBancos.IsEmpty then begin
            LlenadodeTablaTipoBanco();
        end
        else begin
            TipoBancos.DeleteAll();
            LlenadodeTablaTipoBanco();
        end;

        CodigoPostal.DeleteAll();
        LlenarTablaDeCodigoPostal();
    end;

    //----------------------------------Poblado de tabla de Categoria Actividad Económica
    procedure LlenadodeTablasCategoriaEconomica()
    begin
        InsertarCategoriaActividadEconomica('1', 'Agricultura, Servicios Agricolas, Caza, Silvicultura y Pesca');
        InsertarCategoriaActividadEconomica('2', 'Minas, Petróleo y Canteras');
        InsertarCategoriaActividadEconomica('3', 'Industrias Manufactureras');
        InsertarCategoriaActividadEconomica('4', 'Electricidad, Gas y Agua');
        InsertarCategoriaActividadEconomica('5', 'Construcción');
        InsertarCategoriaActividadEconomica('6', 'Comercio por mayor');
        InsertarCategoriaActividadEconomica('7', 'Comercio por menor');
        InsertarCategoriaActividadEconomica('8', 'Restaurantes, Cafes y otros establecimientos que expenden comidas y bebidas');
        InsertarCategoriaActividadEconomica('9', 'Transporte, Almacenamiento y Comunicaciones');
        InsertarCategoriaActividadEconomica('10', 'Finanzas, Seguros, Bienes Inmuebles y Servicios Tecnicos, Profesionales y Otros');
        InsertarCategoriaActividadEconomica('11', 'Servicios Estatales, Sociales, Personales e Internacionales');
        InsertarCategoriaActividadEconomica('12', 'Servicios Sociales e Instrucción Pública');
        InsertarCategoriaActividadEconomica('13', 'Servicios Médicos y Odontológicos; Otros Servicios de Sanidad y Veterinaria');
        InsertarCategoriaActividadEconomica('14', 'Actividades no Especificadas y Otras');
    end;

    //-------------------------------------Poblado de tabla Subcategoría económica
    procedure LlenadodeTablasSubcategoriaEconomica()
    begin
        InsertarSubcategoriaActividadEconomica('1', 'Producción agropecuaria', '1');
        InsertarSubcategoriaActividadEconomica('2', 'Servicios agrícolas', '1');
        InsertarSubcategoriaActividadEconomica('3', 'Caza', '1');
        InsertarSubcategoriaActividadEconomica('4', 'Silvicultura', '1');
        InsertarSubcategoriaActividadEconomica('5', 'Pesca', '1');
        InsertarSubcategoriaActividadEconomica('6', 'Minas, petróleo y canteras', '2');
        InsertarSubcategoriaActividadEconomica('7', 'Productos alimenticios', '3');
        InsertarSubcategoriaActividadEconomica('8', 'Industrias de bebidas', '3');
        InsertarSubcategoriaActividadEconomica('9', 'Industrias del tabaco', '3');
        InsertarSubcategoriaActividadEconomica('10', 'Industria textil', '3');
        InsertarSubcategoriaActividadEconomica('11', 'Confección de prendas de vestir', '3');
        InsertarSubcategoriaActividadEconomica('12', 'Industria del cuero', '3');
        InsertarSubcategoriaActividadEconomica('13', 'Industria de la madera y corcho', '3');
        InsertarSubcategoriaActividadEconomica('14', 'Industria del papel, imprenta y editoriales', '3');
        InsertarSubcategoriaActividadEconomica('15', 'Fabricación de substancias químicas industriales', '3');
        InsertarSubcategoriaActividadEconomica('16', 'Fabricación de otros productos químicos', '3');
        InsertarSubcategoriaActividadEconomica('17', 'Fabricación de productos derivados del petróleo y del carbón', '3');
        InsertarSubcategoriaActividadEconomica('18', 'Fabricación de productos de caucho', '3');
        InsertarSubcategoriaActividadEconomica('19', 'Fabricación de productos minerales no metálicos, exceptuando los derivados del petróleo', '3');
        InsertarSubcategoriaActividadEconomica('20', 'Industrias metálicas básicas', '3');
        InsertarSubcategoriaActividadEconomica('21', 'Fabricación de productos metálicos exceptuando maquinaria y equipo', '3');
        InsertarSubcategoriaActividadEconomica('22', 'Construcción de maquinaria, exceptuando la eléctrica', '3');
        InsertarSubcategoriaActividadEconomica('23', 'Construcción de maquinaria, aparatos, accesorios y suministros eléctricos', '3');
        InsertarSubcategoriaActividadEconomica('24', 'Construcción de material de transporte', '3');
        InsertarSubcategoriaActividadEconomica('25', 'Fabricación de equipo personal y científico e instrumentos de medida y de control no clasificados', '3');
        InsertarSubcategoriaActividadEconomica('26', 'Otras industrias manufactureras', '3');
        InsertarSubcategoriaActividadEconomica('27', 'Electricidad, gas y agua', '4');
        InsertarSubcategoriaActividadEconomica('28', 'Construcción', '5');
        InsertarSubcategoriaActividadEconomica('29', 'Productos agrícolas, de la caza, de la pesca y forestales', '6');
        InsertarSubcategoriaActividadEconomica('30', 'Minería', '6');
        InsertarSubcategoriaActividadEconomica('31', 'Productos alimenticios', '6');
        InsertarSubcategoriaActividadEconomica('32', 'Bebidas y tabaco', '6');
        InsertarSubcategoriaActividadEconomica('33', 'Textiles, prendas de vestir y cueros', '6');
        InsertarSubcategoriaActividadEconomica('34', 'Madera, papel y derivados', '6');
        InsertarSubcategoriaActividadEconomica('35', 'Substancias químicas industriales y materias primas para la elaboración de plásticos', '6');
        InsertarSubcategoriaActividadEconomica('36', 'Porcelana, loza, vidrio y materiales para la costrucción', '6');
        InsertarSubcategoriaActividadEconomica('37', 'Productos metálicos', '6');
        InsertarSubcategoriaActividadEconomica('38', 'Motores, máquinas y equipos (industriales, comerciales, domésticos y científicos)', '6');
        InsertarSubcategoriaActividadEconomica('39', 'Material de transporte', '6');
        InsertarSubcategoriaActividadEconomica('40', 'Comercio por mayor no clasificado', '6');
        InsertarSubcategoriaActividadEconomica('41', 'Casas de remate', '7');
        InsertarSubcategoriaActividadEconomica('42', 'Productos alimenticios', '7');
        InsertarSubcategoriaActividadEconomica('43', 'Cigarrerías y agencias de lotería', '7');
        InsertarSubcategoriaActividadEconomica('44', 'Textiles, prendas de vestir y cueros', '7');
        InsertarSubcategoriaActividadEconomica('45', 'Comercio minorista diverso', '7');
        InsertarSubcategoriaActividadEconomica('46', 'Restaurantes, cafés y otros establecimientos que expenden comidas y bebidas', '8');
        InsertarSubcategoriaActividadEconomica('47', 'Hoteles, casas de huéspedes y otros lugares de alojamiento', '8');
        InsertarSubcategoriaActividadEconomica('48', 'Transporte', '9');
        InsertarSubcategoriaActividadEconomica('49', 'Servicios conexos', '9');
        InsertarSubcategoriaActividadEconomica('50', 'Comunicaciones', '9');
        InsertarSubcategoriaActividadEconomica('51', 'Instituciones, agencias y servicios financieros', '10');
        InsertarSubcategoriaActividadEconomica('52', 'Seguros', '10');
        InsertarSubcategoriaActividadEconomica('53', 'Explotación de bienes inmuebles', '10');
        InsertarSubcategoriaActividadEconomica('54', 'Servicios técinos y profesionales que trabajen en forma independiente', '10');
        InsertarSubcategoriaActividadEconomica('55', 'Servicios estatales, sociales, personales e internacionales', '11');
        InsertarSubcategoriaActividadEconomica('56', 'Servicios sociales e instrucción pública', '12');
        InsertarSubcategoriaActividadEconomica('57', 'Institutos de investigación y científicos', '12');
        InsertarSubcategoriaActividadEconomica('58', 'Servicios médicos y odontológicos; otros servicios de sanidad y veterinaria', '13');
        InsertarSubcategoriaActividadEconomica('59', 'Instituciones de asistencia social', '13');
        InsertarSubcategoriaActividadEconomica('60', 'Asociaciones comerciales, profesionales y laborales', '13');
        InsertarSubcategoriaActividadEconomica('61', 'Servicios de diversión y esparcimiento y servicios culturales', '13');
        InsertarSubcategoriaActividadEconomica('62', 'Organizaciones internacionales y otros organismos extraterritoriales', '13');
        InsertarSubcategoriaActividadEconomica('63', 'Actividades no especificadas y otras', '13');
        InsertarSubcategoriaActividadEconomica('64', 'Servicios Personales y del Hogar', '13');

    end;

    //---------------------------------------------Poblado de tabla tipo de banco
    procedure LlenadodeTablaTipoBanco()
    begin
        InsertarTipoBanco('1', 'Estatal', 'Banco estatal');
        InsertarTipoBanco('2', 'Internacional', 'Banco de origen extranjero');
        InsertarTipoBanco('3', 'Establecido en Chile', 'Banco establecido en Chile');
    end;

    //---------------------------------------Poblado de tabla Tipo transacción
    procedure LlenadoDeTablaTipoTransaccion()
    begin
        InsertarTipoTransaccion('1', 'Compras del giro');
        InsertarTipoTransaccion('2', 'Compras en Supermercados o similares');
        InsertarTipoTransaccion('3', 'Adquisición Bien Raíz');
        InsertarTipoTransaccion('4', 'Compra Activo Fijo');
        InsertarTipoTransaccion('5', 'Compra con IVA Uso Común');
        InsertarTipoTransaccion('6', 'Compra sin derecho a crédito');
        InsertarTipoTransaccion('7', 'Compra que no corresponde incluir');
    end;


    //-------------------------------------------Poblado de tabla Bancos
    procedure LlenadoDeTablaBanco()
    begin
        InsertarBanco('1', 'Banco de Chile', '3');
        InsertarBanco('12', 'Banco Estado', '1');
        InsertarBanco('14', 'Scotiabank Chile', '2');
        InsertarBanco('16', 'Banco crédito e inversiones', '3');
        InsertarBanco('17', 'Banco Do Brasil', '2');
        InsertarBanco('28', 'Banco Bice', '3');
        InsertarBanco('31', 'HSBC Bank Chile', '2');
        InsertarBanco('37', 'Banco Santander Chile', '');
        InsertarBanco('39', 'Itaú Corpbanca', '3');
        InsertarBanco('41', 'JP Morgan Chase Bank', '');
        InsertarBanco('43', 'Banco de la Nación Argentina', '2');
        InsertarBanco('45', 'The Bank of Tokio - Mitsubishi UFJ', '2');
        InsertarBanco('49', 'Banco Security', '');
        InsertarBanco('504', 'Banco Bilbao Vizcaya Argentaria Chile (BBVA)', '');
        InsertarBanco('51', 'Banco Falabella', '3');
        InsertarBanco('53', 'Banco Ripley', '3');
        InsertarBanco('54', 'Rabobank Chile', '');
        InsertarBanco('55', 'Banco Consorcio', '3');
        InsertarBanco('56', 'Banco Penta', '3');
        InsertarBanco('59', 'Banco BTG Pactual Chile', '2');
        InsertarBanco('60', 'China Construction Bank', '2');
        InsertarBanco('61', 'Bank of China', '2');
        InsertarBanco('9', 'Banco internacional', '');

    end;

    //---------------------------------Poblado de tabla de tipo de documento
    procedure LlenadoDeTablaTipoDocumentos()
    begin
        InsertarTipoDocumentos('33', 'Factura electrónica');
        InsertarTipoDocumentos('34', 'Factura no afecta o exenta electrónica');
        InsertarTipoDocumentos('38', 'Boleta exenta');
        InsertarTipoDocumentos('39', 'Boleta electrónica');
        InsertarTipoDocumentos('41', 'Boleta exenta electrónica');
        InsertarTipoDocumentos('43', 'Liquidación factura electrónica');
        InsertarTipoDocumentos('46', 'Factura de compra electrónica');
        InsertarTipoDocumentos('52', 'Guía de despacho electrónica');
        InsertarTipoDocumentos('56', 'Nota de débito electrónica');
        InsertarTipoDocumentos('61', 'Nota de crédito electrónica');
        InsertarTipoDocumentos('100', 'Boleta de honorarios elect.');
    end;

    //-------------------------------------------------------Poblado de tabla actividad económica
    procedure LlenadodeTablasActividadEconomica()
    begin
        //Categoria: ACTIVIDADES NO ESPECIFICADAS Y OTRAS (14)
        //Subcategoria: ACTIVIDADES NO ESPECIFICADAS Y OTRAS (64)
        InsertarActividadEconomica('00001', 'Actividades no especificadas', '14', '64');
        InsertarActividadEconomica('00002', 'Jubilados, pensionados, montepiados, estudiantes, dueñas de casa , religiosas y religiosos', '14', '64');
        //Categoría: AGRICULTURA, SERVICIOS AGRICOLAS, CAZA, SILVICULTURA Y PESCA (1)
        //Subcategoría: PRODUCCIÓN AGROPECUARIA (1)
        InsertarActividadEconomica('11111', 'Cereales, oleaginosas, forrajeras', '1', '1');
        InsertarActividadEconomica('11112', 'Arroz', '1', '1');
        InsertarActividadEconomica('11113', 'Tabaco', '1', '1');
        InsertarActividadEconomica('11114', 'Hortalizas y legumbres', '1', '1');
        InsertarActividadEconomica('11115', 'Papas', '1', '');
        InsertarActividadEconomica('11119', 'Otros productos agrícolas no clasificados en otra parte', '1', '1');
        InsertarActividadEconomica('11121', 'Cría de ganado bovino', '1', '1');
        InsertarActividadEconomica('11122', 'Cría de animales finos', '1', '1');
        InsertarActividadEconomica('11123', 'Producción de leche', '1', '1');
        InsertarActividadEconomica('11124', 'Cría de ganado ovino y su explotación lanera', '1', '1');
        InsertarActividadEconomica('11125', 'Cría de ganado porcino', '1', '1');
        InsertarActividadEconomica('11126', 'Cría de animales destinados a la producción de piel', '1', '1');
        InsertarActividadEconomica('11127', 'Cría de aves, para producción de carnes y huevos', '1', '1');
        InsertarActividadEconomica('11128', 'Apicultura', '1', '1');
        InsertarActividadEconomica('11129', 'Cría y explotación de animales no clasificados en otra parte', '1', '1');
        InsertarActividadEconomica('11131', 'Vid', '1', '1');
        InsertarActividadEconomica('11132', 'Frutales', '1', '1');
        InsertarActividadEconomica('11139', 'Olivos, nogales y frutos no clasificados en otra parte', '1', '1');
        InsertarActividadEconomica('11151', 'Sericultura', '1', '1');
        InsertarActividadEconomica('11171', 'Flores, plantas de interior y viveros', '1', '1');
        InsertarActividadEconomica('11191', 'Otros cultivos no clasificados en otra parte', '1', '1');
        InsertarActividadEconomica('11192', 'Elaboración de productos agropecuarios en explotación agrícola y plantaciones cuando no pueden separarse la producción y la elaboración', '1', '1');
        //Subcategoría: SERVICIOS AGRÍCOLAS (2)
        InsertarActividadEconomica('11201', 'Recoleccción, empacado, trilla, descaramiento y desgrane', '1', '2');
        InsertarActividadEconomica('11202', 'Roturación y siembra', '1', '2');
        InsertarActividadEconomica('11203', 'Destrucción de plagas; fumigación', '1', '2');
        InsertarActividadEconomica('11205', 'Otros servicios agrícolas', '1', '2');
        //Subcategoría: CAZA (3)
        InsertarActividadEconomica('11301', 'Caza ordinaria y mediante trampas', '1', '3');
        InsertarActividadEconomica('11302', 'Repoblación de animales', '1', '3');
        //Subcategoría: SILVICULTURA (4)
        InsertarActividadEconomica('12101', 'Explotación de bosques', '1', '4');
        InsertarActividadEconomica('12102', 'Servicios forestales', '1', '4');
        InsertarActividadEconomica('12103', 'Forestación', '1', '4');
        InsertarActividadEconomica('12109', 'Otras actividades afines (incluye recolección de productos silvestres)', '1', '4');
        InsertarActividadEconomica('12201', 'Corta de madera, desbaste, productos forestales cortados, leña, carbón vegetal (incluye contratistas de extracción de madera)', '1', '4');
        //sUBCATEGORÍA: PESCA (5)
        InsertarActividadEconomica('13011', 'Pesca de altura, litoral costera y en estuarios', '1', '5');
        InsertarActividadEconomica('13021', 'Caza de ballena, foca, lobo marino y otros', '1', '5');
        InsertarActividadEconomica('13031', 'Ostricultura', '1', '5');
        InsertarActividadEconomica('13041', 'Reproducción peces y mariscos', '1', '5');
        InsertarActividadEconomica('13051', 'Explotación frutos acuáticos, algas, etc', '1', '5');
        InsertarActividadEconomica('13061', 'Servicios prospección pesquera', '1', '5');
        //Categoria: MINAS, PETROLEO Y CANTERAS (2)
        //Subcategoria: MINAS, PETROLEO Y CANTERAS (6)
        InsertarActividadEconomica('21001', 'Explotación de minas de carbón', '2', '6');
        InsertarActividadEconomica('22001', 'Producción de petróleo crudo y gas natural', '2', '6');
        InsertarActividadEconomica('23011', 'Extracción de mineral de hierro', '2', '6');
        InsertarActividadEconomica('23031', 'Gran minería del cobre', '2', '6');
        InsertarActividadEconomica('23032', 'Mediana minería del cobre', '2', '6');
        InsertarActividadEconomica('23033', 'Pequeña minería del cobre', '2', '6');
        InsertarActividadEconomica('23041', 'Otros minerales metálicos: Molibdeno, plomo, zinc, mercurio, plata, manganeso, etc.', '2', '6');
        InsertarActividadEconomica('29011', 'Extracción de piedra, arcilla y arena', '2', '6');
        InsertarActividadEconomica('29014', 'Extracción de piedra caliza y yeso', '2', '6');
        InsertarActividadEconomica('29021', 'Extracción de minerales para la fabricación de abonos y productos químicos', '2', '6');
        InsertarActividadEconomica('29022', 'Salitre natural', '2', '6');
        InsertarActividadEconomica('29031', 'Explotación de minas de sal, incluida la molienda y refinación en salinas', '2', '6');
        InsertarActividadEconomica('29090', 'Extracción de minerales no clasificados en otra parte', '2', '6');
        //Categoria: INDUSTRIAS MANUFACTURERAS (3)
        //Subcategoria: PRODUCTOS ALIMENTICIOS (7)
        InsertarActividadEconomica('31111', 'Matanza de ganado', '3', '7');
        InsertarActividadEconomica('31112', 'Frigoríficos relacionados con la conservacion de todo tipo de carnes. (Los relacionados con la conservación de frutas van en el 71921)', '3', '7');
        InsertarActividadEconomica('31113', 'Matanza de aves', '3', '7');
        InsertarActividadEconomica('31115', 'Preparación de fiambres, embutidos y conservas de carnes', '3', '7');
        InsertarActividadEconomica('31121', 'Fabricación de mantequilla, queso, quesillos, crema y yogurt', '3', '7');
        InsertarActividadEconomica('31122', 'Fabricación de leche condensada, en polvo y elaborada', '3', '7');
        InsertarActividadEconomica('31123', 'Fabricación de helados, sorbetes y otros postres', '3', '7');
        InsertarActividadEconomica('31131', 'Elaboración y envasado de frutas y legumbres (incluido los jugos)', '3', '7');
        InsertarActividadEconomica('31132', ' Elaboración de pasas, frutas y legumbres secas', '3', '7');
        InsertarActividadEconomica('31133', 'Dulces, mermeladas y jaleas', '3', '7');
        InsertarActividadEconomica('31134', 'Conservas, caldos concentrados y otros alimentos deshidratados', '3', '7');
        InsertarActividadEconomica('31141', 'Elaboración de pescado, crustáceos y otros productos marinos', '3', '7');
        InsertarActividadEconomica('31151', 'Elaboración de aceites, grasas vegetales y subproductos', '3', '7');
        InsertarActividadEconomica('31152', 'Elaboración de aceites y grasas animales no comestibles', '3', '7');
        InsertarActividadEconomica('31153', 'Extracción de aceites de pescado y de otros animales marinos', '3', '7');
        InsertarActividadEconomica('31154', 'Producción de harina de pescado', '3', '7');
        InsertarActividadEconomica('31161', 'Molinos harineros y otros', '3', '7');
        InsertarActividadEconomica('31163', 'Elaboración de alimentos de cereales', '3', '7');
        InsertarActividadEconomica('31164', 'Elaboración de semillas secas de leguminosas', '3', '7');
        InsertarActividadEconomica('31171', 'Fabricación de pan y demás productos de panadería (excluye puestos de pan, que van en el 62171)', '3', '7');
        InsertarActividadEconomica('31172', 'Fabricación de galletas', '3', '7');
        InsertarActividadEconomica('31173', 'Pastelería', '3', '7');
        InsertarActividadEconomica('31174', 'Elaboración de fideos, tallarines y otras pastas', '3', '7');
        InsertarActividadEconomica('31181', 'Fabricación y refinación de azúcar', '3', '7');
        InsertarActividadEconomica('31191', 'Fabricación de cacao y chocolate en polvo', '3', '7');
        InsertarActividadEconomica('31192', 'Fabricación de confites, frutas confitadas y toda clase de artículos de confitería', '3', '7');
        InsertarActividadEconomica('31211', 'Condimentos, mostazas y vinagres', '3', '7');
        InsertarActividadEconomica('31212', 'Almidón y sus derivados', '3', '7');
        InsertarActividadEconomica('31213', 'Fabricación de hielo natural', '3', '7');
        InsertarActividadEconomica('31214', 'Levaduras', '3', '7');
        InsertarActividadEconomica('31215', 'Elaboración de té', '3', '7');
        InsertarActividadEconomica('31216', 'Tostado y molienda de café', '3', '7');
        InsertarActividadEconomica('31219', 'Industrias alimenticias no clasificadas en otra parte', '3', '7');
        InsertarActividadEconomica('31221', 'Elaboración de alimentos preparados para animales', '3', '7');
        //Subcategoria: INDUSTRIAS DE BEBIDAS (8)
        InsertarActividadEconomica('31311', 'Destilación de alcohol etílico', '3', '8');
        InsertarActividadEconomica('31312', 'Destilación, rectificación de bebidas alcohólicas (las empresas que solo embotellan, sin mezclar, van en el 61323)', '3', '8');
        InsertarActividadEconomica('31321', 'Fabricación de vinos (las empresas que sólo embotellan, sin mezclar, van en el 61323)', '3', '8');
        InsertarActividadEconomica('31322', 'Elaboración de sidra otras bebidas fermentadas, excepto las malteadas', '3', '8');
        InsertarActividadEconomica('31331', 'Elaboración de malta, cerveza y bebidas mateadas', '3', '8');
        InsertarActividadEconomica('31341', 'Elaboración de bebidas no alcohólicas y aguas minerales clasificadas y embotellado de aguas naturales y minerales', '3', '8');
        //Subcategoria: INDUSTRIAS DEL TABACO (9)
        InsertarActividadEconomica('31401', 'Fabricación de cigarrillos y cigarros', '3', '9');
        InsertarActividadEconomica('31402', 'Fabricación de otros productos del tabaco', '3', '9');
        //Subcategoria: INDUSTRIA TEXTIL (10)
        InsertarActividadEconomica('32111', 'Hilanderías', '3', '10');
        InsertarActividadEconomica('32112', 'Tejidos (se excluye prendas de vestir de lana, que van en el 32131 y 32132)', '3', '10');
        InsertarActividadEconomica('32113', 'Tintorerías industriales y acabado de textiles', '3', '10');
        InsertarActividadEconomica('32114', 'Estampados', '3', '10');
        InsertarActividadEconomica('32117', 'Fabricación de otros productos textiles no clasificados en otra parte', '3', '10');
        InsertarActividadEconomica('32121', 'Confección de frazadas, mantas y cortinas', '3', '10');
        InsertarActividadEconomica('32122', 'Confección de sábanas, fundas de almohadas, mantelería', '3', '10');
        InsertarActividadEconomica('32124', 'Confección de artículos de lona y bolsas', '3', '10');
        InsertarActividadEconomica('32126', 'Talleres de pespuntes, plisados y encarrujados para la industria', '3', '10');
        InsertarActividadEconomica('32131', 'Fabricación de medias y calcetines', '3', '10');
        InsertarActividadEconomica('32132', 'Fabricación y acabado de tejidos de punto', '3', '10');
        InsertarActividadEconomica('32141', 'Fabricación de tapices y alfombras', '3', '10');
        InsertarActividadEconomica('32151', 'Fabricación de sogas, cables, cordeles, redes y otros artículos conexos', '3', '10');
        InsertarActividadEconomica('32191', 'Fabricación de textiles no clasificados en otra parte (excepto prendas de vestir)', '3', '10');
        //Subcategoria: CONFECCIÓN DE PRENDAS DE VESTIR (11)
        InsertarActividadEconomica('32201', 'Confección de prendas de vestir', '3', '11');
        InsertarActividadEconomica('32202', 'Confección de sombreros, guantes y otros accesorios para vestir', '3', '11');
        InsertarActividadEconomica('32204', 'Confección de prendas de vestir de cuero', '3', '11');
        InsertarActividadEconomica('32205', 'Confección de prendas de vestir de piel', '3', '11');
        InsertarActividadEconomica('32206', 'Confección de impermeables, casacas, parkas', '3', '11');
        InsertarActividadEconomica('32207', 'Confección de uniformes y accesorios', '3', '11');
        //Subcategoria: INDUSTRIA DEL CUERO (12)
        InsertarActividadEconomica('32311', 'Curtiduría y talleres de acabado', '3', '12');
        InsertarActividadEconomica('32321', 'Preparación y teñido de pieles', '3', '12');
        InsertarActividadEconomica('32322', 'Confección de alfombras, felpudos y otros artículos de piel no clasificados en otra parte', '3', '12');
        InsertarActividadEconomica('32331', 'Fabricación de maletas, carteras, billeteras, cigarreras', '3', '12');
        InsertarActividadEconomica('32332', 'Fabricación de sillas de montar, arneses, látigos', '3', '12');
        InsertarActividadEconomica('32333', 'Fabricación de otros artículos análogos no clasificados en otra parte', '3', '12');
        InsertarActividadEconomica('32401', 'Fabricación de calzado y botas de cuero', '3', '12');
        InsertarActividadEconomica('32402', 'Fabricación de calzado de tela y otros materiales, excepto el de madera, de caucho vulcanizado o moldeado o de plástico', '3', '12');
        //Subcategoria: INDUSTRIA DE LA MADERA Y CORCHO  (13)
        InsertarActividadEconomica('33111', 'Aserraderos y otros talleres para preparar madera', '3', '13');
        InsertarActividadEconomica('33112', 'Maderas terciadas, prensadas y aglomeradas', '3', '13');
        InsertarActividadEconomica('33113', 'Fabricación de puertas y ventanas', '3', '13');
        InsertarActividadEconomica('33114', 'Carpintería de obra', '3', '13');
        InsertarActividadEconomica('33115', 'Casas prefabricadas de madera', '3', '13');
        InsertarActividadEconomica('33121', 'Envases de madera y de caña', '3', '13');
        InsertarActividadEconomica('33193', 'Fabricación de productos de madera y de corcho no clasificados en otra parte', '3', '13');
        InsertarActividadEconomica('33201', 'Fabricación de muebles y accesorios, excepto los que son principalmente metálicos (incluye tapicería de muebles)', '3', '13');
        InsertarActividadEconomica('33204', 'Fabricación de persianas', '3', '13');
        //Subcategoria: INDUSTRIA DEL PAPEL, IMPRENTA Y EDITORIALES (14)
        InsertarActividadEconomica('34111', 'Fabricación de pulpa de madera', '3', '14');
        InsertarActividadEconomica('34112', 'Fabricación de papel y cartón', '3', '14');
        InsertarActividadEconomica('34121', 'Fabricación de envases de papel y cartón', '3', '14');
        InsertarActividadEconomica('34191', 'Fabricación de artículos de pulpa, papel y cartón no especificados en otra parte', '3', '14');
        InsertarActividadEconomica('34201', 'Imprenta y encuadernación', '3', '14');
        InsertarActividadEconomica('34202', 'Fotograbado y litografía', '3', '14');
        InsertarActividadEconomica('34203', 'Fabricación de tarjetas, sobres y papel de escribir con membrete, calendarios, afiches, etiquetas', '3', '14');
        InsertarActividadEconomica('34204', 'Editoriales', '3', '14');
        InsertarActividadEconomica('34205', 'Fotocopias y otros servicios relacionados con las imprentas', '3', '14');
        //Subcategoria: FABRICACIÓN DE SUBSTANCIAS QUÍMICAS INDUSTRIALES (15)
        InsertarActividadEconomica('35111', 'Fabricación de productos químicos industriales básicos, orgánicos e inorgánicos (incluye salitre sintético)', '3', '15');
        InsertarActividadEconomica('35121', 'Fabricación de abonos', '3', '15');
        InsertarActividadEconomica('35122', 'Fabricación de plaguicidas, insecticidas, fungicidas y herbicidas', '3', '15');
        InsertarActividadEconomica('35131', 'Fabricación de resinas sintéticas', '3', '15');
        InsertarActividadEconomica('35132', 'Fabricación de materias plásticas', '3', '15');
        InsertarActividadEconomica('35133', 'Fabricación de fibras artificiales excepto el vidrio', '3', '15');
        //Subcategoria: FABRICACIÓN DE OTROS PRODUCTOS QUÍMICOS (16)
        InsertarActividadEconomica('35211', 'Fabricación de pinturas, barnices, lacas, esmaltes y pastas para charoles', '3', '16');
        InsertarActividadEconomica('35212', 'Fabricacíon de productos conexos', '3', '16');
        InsertarActividadEconomica('35221', 'Fabricación de productos farmacéuticos y medicamentos', '3', '16');
        InsertarActividadEconomica('35222', 'Preparados farmacéuticos para animales', '3', '16');
        InsertarActividadEconomica('35231', 'Fabricación de jabones, detergentes y champúes', '3', '16');
        InsertarActividadEconomica('35232', 'Fabricación de perfumes, cosméticos, lociones, pasta dentífica y otros productos de tocador', '3', '16');
        InsertarActividadEconomica('35291', 'Fabricación de ceras', '3', '16');
        InsertarActividadEconomica('35292', 'Fabricación de desinfectantes y desodorizantes', '3', '16');
        InsertarActividadEconomica('35293', 'Fabricación de explosivos y municiones', '3', '16');
        InsertarActividadEconomica('35294', 'Fabricación de colas, adhesivos, aprestos y cementos', '3', '16');
        InsertarActividadEconomica('35295', 'Fabricación de velas de alumbrar', '3', '16');
        InsertarActividadEconomica('35296', 'Fabricación de tintas', '3', '16');
        InsertarActividadEconomica('35299', 'Otros productos químicos diversos no clasificados en otra parte', '3', '16');
        //Subcategoria: FABRICACIÓN DE PRODUCTOS DERIVADOS DEL PETRÓLEO Y DEL CARBÓN (17)
        InsertarActividadEconomica('35301', 'Refinería de petróleo', '3', '17');
        InsertarActividadEconomica('35401', 'Fabricación de materiales para pavimento y techado a base de asfalto', '3', '17');
        InsertarActividadEconomica('35402', 'Fabricación de briquetas de combustibles y otros productos diversos derivados del petróleo y del carbón', '3', '17');
        //Subcategoria: FABRICACIÓN DE PRODUCTOS DE CAUCHO (18)
        InsertarActividadEconomica('35511', 'Fabricación de camaras y neumáticos o llantas', '3', '18');
        InsertarActividadEconomica('35512', 'Recauchaje', '3', '18');
        InsertarActividadEconomica('35591', 'Fabricación de productos de caucho no clasificados en otra parte', '3', '18');
        InsertarActividadEconomica('35601', 'Fabricación de productos plásticos diversos no clasificados en otra parte', '3', '18');
        //Subcategoria: FABRICACIÓN DE PRODUCTOS MINERALES NO METÁLICOS, EXCEPTUANDO LOS DERIVADOS DEL PETRÓLEO (19)
        InsertarActividadEconomica('36101', 'Fabricación de cerámicas', '3', '19');
        InsertarActividadEconomica('36103', 'Baldosines (excluye baldosas y revestimientos que van en el 36991)', '3', '19');
        InsertarActividadEconomica('36104', 'Otros objetos de barro, loza o porcelana no clasificados en otra parte', '3', '19');
        InsertarActividadEconomica('36201', 'Fabricación de vidrios planos y templados', '3', '19');
        InsertarActividadEconomica('36202', 'Fabricación de espejos y cristales', '3', '19');
        InsertarActividadEconomica('36203', 'Otros productos de vidrio no clasificados en otra parte', '3', '19');
        InsertarActividadEconomica('36204', 'Parabrisas y vidrios para vehículos', '3', '19');
        InsertarActividadEconomica('36911', 'Fabricación de ladrillos', '3', '19');
        InsertarActividadEconomica('36914', 'Fabricación de rejillas y tabiques', '3', '19');
        InsertarActividadEconomica('36915', 'Fabricación de material refractario', '3', '19');
        InsertarActividadEconomica('36921', 'Fabricación de cemento, cal y yeso', '3', '19');
        InsertarActividadEconomica('36991', 'Fabricación de productos minerales no metálicos no especificados en otra parte (incluye baldosas y revestimientos)', '3', '20');
        //Subcategoria: INDUSTRIAS METÁLICAS BÁSICAS (20)
        InsertarActividadEconomica('37101', 'Fabricación de productos primarios de hierro y acero', '3', '20');
        InsertarActividadEconomica('37102', 'Laminadoras y otras industrias básicas de hierro y acero', '3', '20');
        InsertarActividadEconomica('37201', 'Fabricación de productos primarios de metales no ferrosos', '3', '21');
        //Subcategoria: FABRICACIÓN DE PRODUCTOS METÁLICOS EXCEPTUANDO MAQUINARIA Y EQUIPO (21)
        InsertarActividadEconomica('38111', 'Fabricación de cuchillería', '3', '21');
        InsertarActividadEconomica('38112', 'Fabricación de herramientas manuales y de artículos de ferreterías', '3', '21');
        InsertarActividadEconomica('38121', 'Fabricación de muebles y accesorios principalmente metálicos', '3', '21');
        InsertarActividadEconomica('38131', 'Fabricación de estructuras y estanques metálicos', '3', '21');
        InsertarActividadEconomica('38133', 'Fabricación de galpones, puertas y ventanas metálicas', '3', '21');
        InsertarActividadEconomica('38134', 'Edificios metálicos prefabricados', '3', '21');
        InsertarActividadEconomica('38135', 'Montaje e instalación de elementos prefabricados', '3', '21');
        InsertarActividadEconomica('38191', 'Hojalatería (incluye envases de lata)', '3', '21');
        InsertarActividadEconomica('38192', 'Estampados de metal y productos de tornería', '3', '21');
        InsertarActividadEconomica('38194', 'Fabricación de tornillos, clavos, grapas, alambre', '3', '21');
        InsertarActividadEconomica('38195', 'Fabricación de artículos sanitarios y de plomería de hierro esmaltado y de latón', '3', '21');
        InsertarActividadEconomica('38196', 'Esmaltado, barnizado, lacado, galvanizado, chapado y pulido de artículos metálicos', '3', '21');
        InsertarActividadEconomica('38197', 'Fabricación de productos metálicos no clasificados en otra parte', '3', '21');
        //Subcategoria: CONSTRUCCIÓN DE MAQUINARIA, EXCEPTUANDO LA ELÉCTRICA (22)
        InsertarActividadEconomica('38211', 'Fabricación y reparación de motores, turbinas y máquinas de vapor y de gas', '3', '22');
        InsertarActividadEconomica('38221', 'Fabricación y reparación de máquinaria y equipo para la agricultura y ganadería, tales como máquinas mezcladoras, sembradoras, cosechadoras, abonadoras tractores, arados, equipos de riego, segadoras, perforadoras, pulverizadoras, máquinaria para lechería, etc.', '3', '22');
        InsertarActividadEconomica('38231', 'Fabricación y reparación de maquinaria y equipo para trabajar los metales y la madera, tales como: tornos, máquinas de perforar y taladrar, de fresar, rectificar, lijar, forjar, prensar, etc.', '3', '22');
        InsertarActividadEconomica('38241', 'Fabricación y reparación de maquinaria para preparar alimentos', '3', '22');
        InsertarActividadEconomica('38242', 'Fabricación y reparación de maquinaria textil y química', '3', '22');
        InsertarActividadEconomica('38244', 'Fabricación y reparación de máquinas y equipos de imprenta', '3', '22');
        InsertarActividadEconomica('38246', 'Fabricación y reparación de maquinaria y equipo para la industria del petróleo y minería', '3', '22');
        InsertarActividadEconomica('38247', 'Fabricación y reparación de maquinaria y equipos para la industria de la construcción y otras', '3', '22');
        InsertarActividadEconomica('38251', 'Fabricación y reparación de máquinas y equipos de oficina (incluye básculas, dinamómetros, etc.)', '3', '22');
        InsertarActividadEconomica('38252', 'Fabricación y reparación de máquinas y equipos de computación', '3', '22');
        InsertarActividadEconomica('38291', 'Fabricación y reparación de maquinaria y equipo no clasificado en otra parte. ', '3', '23');
        //Subcategoría: CONSTRUCCIÓN DE MAQUINARIA, APARATOS, ACCESORIOS Y SUMINISTROS ELÉCTRICOS  (23)
        InsertarActividadEconomica('38311', 'Construcción y reparación de motores eléctricos', '3', '23');
        InsertarActividadEconomica('38312', 'Construcción y reparación de equipos para la generación, transformación, conmutación, rectificación, control y distribución eléctrica', '3', '23');
        InsertarActividadEconomica('38314', 'Construcción y reparación de aparatos de soldadura eléctrica', '3', '23');
        InsertarActividadEconomica('38315', 'Construcción y reparación de otros aparatos industriales eléctricos no clasificados en otra parte', '3', '23');
        InsertarActividadEconomica('38321', 'Fabricación de receptores de radio y de televisión', '3', '23');
        InsertarActividadEconomica('38322', 'Fabricación de equipos de grabación y reproducción de sonido', '3', '23');
        InsertarActividadEconomica('38323', 'Fabricación de discos, cintas magnéticas , cassettes', '3', '23');
        InsertarActividadEconomica('38324', 'Fabricación de equipos y aparatos de comunicaciones', '3', '23');
        InsertarActividadEconomica('38325', 'Fabricación de piezas y accesorios para radio, televisión y otros de este grupo', '3', '23');
        InsertarActividadEconomica('38326', 'Fabricación de aparatos y válvulas de radiografía, fluoroscopía y otros aparatos de rayos X', '3', '23');
        InsertarActividadEconomica('38331', 'Fabricación de hornos, parrillas, asadores, tostadoras y batidores eléctricos', '3', '23');
        InsertarActividadEconomica('38332', 'Fabricación de planchadoras, ventiladores, enceradoras y aspiradoras y otros aparatos y accesorios eléctricos de uso doméstico', '3', '23');
        InsertarActividadEconomica('38391', 'Fabricación de interruptores, enchufes, timbres, tableros, tapones, resistencias', '3', '23');
        InsertarActividadEconomica('38392', 'Fabricación de ampolletas, tubos eléctricos, focos, pilas eléctricas, linternas', '3', '23');
        InsertarActividadEconomica('38393', 'Fabricación de lámparas', '3', '23');
        InsertarActividadEconomica('38394', 'Fabricación de material eléctrico no clasificado en otra parte', '3', '23');
        //Subcategoria: CONSTRUCCIÓN DE MATERIAL DE TRANSPORTE (24)
        InsertarActividadEconomica('38411', 'Astilleros', '3', '24');
        InsertarActividadEconomica('38412', 'Construcción de motores y piezas para naves', '3', '24');
        InsertarActividadEconomica('38421', 'Construcción, reparación y modificación de maquinaria y equipo ferroviario', '3', '24');
        InsertarActividadEconomica('38431', 'Construcción y montaje de vehículos automóviles', '3', '24');
        InsertarActividadEconomica('38432', 'Fabricación de piezas y accesorios para vehículos automóviles, tales como motores, frenos, embragues, cajas de cambio, transmisiones, ruedas y chassis', '3', '24');
        InsertarActividadEconomica('38434', 'Rectificación de motores', '3', '24');
        InsertarActividadEconomica('38441', 'Fabricación de bicicletas, motocicletas y sus piezas especiales ', '3', '24');
        InsertarActividadEconomica('38451', 'Fabricación y reparación de aeronaves y de sus partes', '3', '24');
        InsertarActividadEconomica('38491', 'Fabricación de material de transporte no clasificado en otra parte', '3', '24');
        //Subcategoria: FABRICACIÓN DE EQUIPO PROFESIONAL Y CIENTÍFICO E INSTRUMENTOS DE MEDIDA Y DE CONTROL NO CLASIFICADOS EN OTRA PARTE Y APARATOS FOTOGRÁFICOS E INSTRUMENTOS DE ÓPTICA (25)
        InsertarActividadEconomica('38511', 'Fabricación y reparación de instrumentos cientificos, de medida, de control y de laboratorio no clasificado en otra parte', '3', '25');
        InsertarActividadEconomica('38512', 'Producción de instrumentos y suministros de cirugía general, cirugía dental y de aparatos ortopédicos y protésicos', '3', '25');
        InsertarActividadEconomica('38521', 'Fabricación de instrumentos de óptica', '3', '25');
        InsertarActividadEconomica('38522', 'Fabricación de artículos de fotografía', '3', '25');
        InsertarActividadEconomica('38523', 'Fabricación de lentes y artículos oftálmicos', '3', '25');
        InsertarActividadEconomica('38531', 'Fabricación de relojes y de sus piezas', '3', '25');
        //Subcategoria: OTRAS INDUSTRIAS MANUFACTURERAS (26)
        InsertarActividadEconomica('39011', 'Fabricación de joyas (excluye las fantasías, que van en el 39099)', '3', '26');
        InsertarActividadEconomica('39012', 'Fabricación de platería', '3', '26');
        InsertarActividadEconomica('39021', 'Fabricación de instrumentos de música', '3', '26');
        InsertarActividadEconomica('39031', 'Fabricación de artículos de deportes, atletismo y camping', '3', '26');
        InsertarActividadEconomica('39091', 'Fabricación de juguetes', '3', '26');
        InsertarActividadEconomica('39092', 'Fabricación de paraguas y bastones', '3', '26');
        InsertarActividadEconomica('39093', 'Fabricación de lápices, lapiceras, bolígrafos y demás artículos de escritorio', '3', '26');
        InsertarActividadEconomica('39094', 'Fabricación de pantallas para lámparas', '3', '26');
        InsertarActividadEconomica('39095', 'Fabricación de escobas y cepillos', '3', '26');
        InsertarActividadEconomica('39099', 'Fabricación de botones, pelucas, fantasías y otros artículos no clasificados en otra parte', '3', '26');
        //Categoria: ELECTRICIDAD, GAS Y AGUA 
        //Subcategoria: ELECTRICIDAD, GAS Y AGUA (27)
        InsertarActividadEconomica('41011', 'Generación, transmisión y distribución de electricidad', '4', '27');
        InsertarActividadEconomica('41021', 'Producción y distribución de gas', '4', '27');
        InsertarActividadEconomica('41031', 'Producción y distribución de vapor y agua caliente', '4', '27');
        InsertarActividadEconomica('42001', 'Captación, purificación y distribución de agua', '4', '27');
        //Categoria: CONSTRUCCION
        //Subcategoria: CONSTRUCCION (28)
        InsertarActividadEconomica('50011', 'Construcción y reparación de edificios', '5', '28');
        InsertarActividadEconomica('50012', 'Demolición de edificios', '5', '28');
        InsertarActividadEconomica('50013', 'Construcción de viviendas', '5', '28');
        InsertarActividadEconomica('50021', 'Construcción de caminos, puentes, aeropuertos, obras públicas en general', '5', '28');
        InsertarActividadEconomica('50022', 'Construcción y pavimentación de aceras y calzadas', '5', '28');
        InsertarActividadEconomica('50023', 'Obras de vías férreas', '5', '28');
        InsertarActividadEconomica('50024', 'Instalaciones hidráulicas, embalses y canales', '5', '28');
        InsertarActividadEconomica('50025', 'Construcción de obras sanitarias y alcantarillado', '5', '28');
        InsertarActividadEconomica('50026', 'Construcción de campos de deportes', '5', '28');
        InsertarActividadEconomica('50027', 'Construcción de refinerias, plantas industriales, mineras', '5', '28');
        InsertarActividadEconomica('50028', 'Construcción de obras marítimas', '5', '28');
        InsertarActividadEconomica('50029', 'Instalaciones de sistemas de comunicación, plantas eléctricas e hidroeléctricas y otras obras no clasificadas en otra parte', '5', '28');
        InsertarActividadEconomica('50031', 'Obras de conservación, mantención, limpieza y pintura de edificios', '5', '28');
        InsertarActividadEconomica('50032', 'Instalación de equipos eléctricos en los edificios', '5', '28');
        InsertarActividadEconomica('50033', 'Instalación de agua, de desagüe y artículos sanitarios', '5', '28');
        InsertarActividadEconomica('50034', 'Construcción e instalación de sistemas de aire acondicionado y calefacción', '5', '28');
        InsertarActividadEconomica('50035', 'Construcción y/o instalación de impermeabilización', '5', '28');
        InsertarActividadEconomica('50036', 'Construcción y/o instalación de obras no clasificadas en otra parte', '5', '28');
        InsertarActividadEconomica('50037', 'Contratistas y subcontratistas', '5', '28');
        //Categoria: COMERCIO POR MAYOR 
        //Subcategoria: PRODUCTOS AGRÍCOLAS, DE LA CAZA, DE LA PESCA Y FORESTAL (29)
        InsertarActividadEconomica('61111', 'Corretaje agrícola, frutícola y lechera', '6', '29');
        InsertarActividadEconomica('61115', 'Corredor de vinos', '6', '29');
        InsertarActividadEconomica('61117', 'Mayoristas de aves y huevos', '6', '29');
        InsertarActividadEconomica('61122', 'Mayoristas de lanas', '6', '29');
        InsertarActividadEconomica('61124', 'Mayoristas de cecinas', '6', '29');
        InsertarActividadEconomica('61125', 'Mayoristas de pescados', '6', '29');
        InsertarActividadEconomica('61126', 'Mayoristas de mariscos', '6', '29');
        InsertarActividadEconomica('61127', 'Corretaje de ganado (ferias de ganado)', '6', '29');
        InsertarActividadEconomica('61129', 'Otros no clasificados', '6', '29');
        //Subcategoria: MINERÍA (30)
        InsertarActividadEconomica('61211', 'Mayorista de minerales', '6', '30');
        //Subcategoria: PRODUCTOS ALIMENTICIOS (31)
        InsertarActividadEconomica('61311', 'Productos alimenticios', '6', '31');
        //Subcategoria: BEBIDAS Y TABACOS (32)
        InsertarActividadEconomica('61321', 'Distribuidores de bebidas no alcoholicas, aguas minerales y cervezas', '6', '32');
        InsertarActividadEconomica('61323', 'Embotelladores mayoristas de alcoholes y licores', '6', '32');
        InsertarActividadEconomica('61333', 'Mayoristas en tabacos y cigarrillos', '6', '32');
        //Subcategoria: TEXTILES, PRENDAS DE VESTIR Y CUEROS (33)
        InsertarActividadEconomica('61341', 'Mayoristas textiles', '6', '33');
        InsertarActividadEconomica('61343', 'Mayoristas de prendas de vestir', '6', '33');
        InsertarActividadEconomica('61344', 'Mayoristas de pieles y cueros', '6', '33');
        InsertarActividadEconomica('61345', 'Mayoristas de talabartería', '6', '33');
        InsertarActividadEconomica('61346', 'Mayoristas en calzados', '6', '33');
        InsertarActividadEconomica('61349', 'Otros mayoristas no clasificados', '6', '33');
        //Subcategoria: MADERA, PAPEL Y DERIVADOS (34)
        InsertarActividadEconomica('61381', 'Mayoristas de maderas', '6', '34');
        InsertarActividadEconomica('61384', 'Distribuidores mayoristas de papel', '6', '34');
        InsertarActividadEconomica('61386', 'Distribuidora, importadora y exportadora de libros y revistas', '6', '34');
        //Subcategoria: SUBSTANCIAS QUÍMICAS INDUSTRIALES Y MATERIAS PRIMAS PARA LA ELABORACIÓN DE PLÁSTICOS (35)
        InsertarActividadEconomica('61412', 'Representantes y distribuidores de productos químicos', '6', '35');
        InsertarActividadEconomica('61414', 'Distribuidora de plásticos y mayoristas en envases y bolsas plásticas', '6', '35');
        InsertarActividadEconomica('61415', 'Mayoristas de juguetes ', '6', '35');
        InsertarActividadEconomica('61417', 'Mayoristas de cañerías y otros artículos de plásticos y de caucho', '6', '35');
        //Subcategoria: PORCELANA, LOZA, VIDRIO Y MATERIALES PARA LA CONSTRUCCIÓN (36)
        InsertarActividadEconomica('61511', 'Mayoristas en porcelana y loza', '6', '36');
        InsertarActividadEconomica('61512', 'Abastecedora de vidrios, espejos y cristales', '6', '36');
        InsertarActividadEconomica('61514', 'Distribuidora de materiales de construcción', '6', '36');
        //Subcategoria: PRODUCTOS METÁLICOS (37)
        InsertarActividadEconomica('61521', 'Compra y venta al por mayor de metales', '6', '37');
        InsertarActividadEconomica('61522', 'Distribuidora de productos Metálicos', '6', '37');
        InsertarActividadEconomica('61523', 'Mayoristas de muebles y accesorios metálicos', '6', '37');
        InsertarActividadEconomica('61524', 'Mayoristas y distribuidoras de artículos de ferretería, herramientas y armerías', '6', '37');
        //Subcategoria: MOTORES, MÁQUINAS Y EQUIPOS (INDUSTRIALES, COMERCIALES, DOMÉSTICOS Y CIENTÍFICOS)(38)
        InsertarActividadEconomica('61531', 'Mayorista de motores, máquinas y equipos y sus repuestos', '6', '38');
        //Subcategoria: MATERIAL DE TRANSPORTE (39)
        InsertarActividadEconomica('61561', 'Importadora y distribuidora de automóviles, camiones y camionetas, motos, repuestos y accesorios', '6', '39');
        InsertarActividadEconomica('61563', 'Otros no clasificados', '6', '39');
        //Subcategoria: COMERCIO POR MAYOR NO CLASIFICADO (40)
        InsertarActividadEconomica('61911', 'Comercio por mayor no clasificado en otra parte', '6', '40');
        //Categoria: COMERCIO POR MENOR (7)
        //Subcategoria: CASAS DE REMATE (41)
        InsertarActividadEconomica('62001', 'Casas de remate, martilleros', '7', '41');
        //Subcategoria: PRODUCTOS ALIMENTICIOS (42)
        InsertarActividadEconomica('62101', 'Almacenes de comestibles', '7', '42');
        InsertarActividadEconomica('62102', 'Venta de galletas', '7', '42');
        InsertarActividadEconomica('62103', 'Supermercados', '7', '42');
        InsertarActividadEconomica('62104', 'Venta de café y té', '7', '42');
        InsertarActividadEconomica('62111', 'Botillerías: Depósitos de vinos, licores y bebidas analcohólicos', '7', '42');
        InsertarActividadEconomica('62121', 'Carnicerías', '7', '42');
        InsertarActividadEconomica('62122', 'Aves y huevos', '7', '42');
        InsertarActividadEconomica('62131', 'Rotiserías y fiambrerías', '7', '42');
        InsertarActividadEconomica('62141', 'Pescaderías y mariscos', '7', '42');
        InsertarActividadEconomica('62151', 'Venta de leche y productos lacteos', '7', '42');
        InsertarActividadEconomica('62161', 'Verdulerías', '7', '42');
        InsertarActividadEconomica('62162', 'Fruterías', '7', '42');
        InsertarActividadEconomica('62171', 'Puestos de pan (sólo venta de pan)', '7', '42');
        InsertarActividadEconomica('62181', 'Confiterias', '7', '42');
        InsertarActividadEconomica('62182', 'Helados y hielo', '7', '42');
        InsertarActividadEconomica('62191', 'Alimentos para animales', '7', '42');
        InsertarActividadEconomica('62199', 'Otros no clasificados en otra parte', '7', '42');
        //Subcategoria: CIGARRERÍAS Y AGENCIAS DE LOTERÍA  (43)
        InsertarActividadEconomica('62311', 'Cigarrerías, tabacos y útiles para fumar', '7', '43');
        InsertarActividadEconomica('62312', 'Agencias de lotería, de polla, polla gol, etc', '7', '43');
        //Subcategoria: TEXTILES, PRENDAS DE VESTIR Y CUEROS (44)
        InsertarActividadEconomica('62410', 'Grandes tiendas', '7', '44');
        InsertarActividadEconomica('62411', 'Calzado', '7', '44');
        InsertarActividadEconomica('62412', 'Prendas de vestir (excepto calzado)', '7', '44');
        InsertarActividadEconomica('62413', 'Tiendas de géneros, telas y sedas', '7', '44');
        InsertarActividadEconomica('62414', 'Venta de lana', '7', '44');
        InsertarActividadEconomica('62415', 'Carteras', '7', '44');
        InsertarActividadEconomica('62416', 'Sombreros, guantes, pañuelos y corbatas', '7', '44');
        InsertarActividadEconomica('62417', 'Ropa interior, pijamas, medias y calcetines', '7', '44');
        InsertarActividadEconomica('62421', 'Maleterías y talabarterías', '7', '44');
        InsertarActividadEconomica('62431', 'Colchones', '7', '44');
        InsertarActividadEconomica('62432', 'Tapicerías, alfombras, cortinas', '7', '44');
        InsertarActividadEconomica('62433', 'Sábanas, cubrecamas, manteles, toallas, etc', '7', '44');
        InsertarActividadEconomica('62459', 'Otros no clasificados', '7', '44');
        //Subcategoria: COMERCIO MINORISTA DIVERSO (45)
        InsertarActividadEconomica('62511', 'Artículos de aseo y detergentes', '7', '45');
        InsertarActividadEconomica('62512', 'Artículos del hogar: Cocinas, máquinas de lavar, ventiladoras, enceradoras, estufas, jugueras, etc', '7', '45');
        InsertarActividadEconomica('62513', 'Aparatos y artefactos eléctricos para iluminación y lámparas', '7', '45');
        InsertarActividadEconomica('62514', 'Armerías, artículos de caza y pesca', '7', '45');
        InsertarActividadEconomica('62515', 'Antigüedades y galerías de arte', '7', '45');
        InsertarActividadEconomica('62516', 'Artículos religiosos', '7', '45');
        InsertarActividadEconomica('62517', 'Boutiques', '7', '45');
        InsertarActividadEconomica('62518', 'Artículos ortopédicos', '7', '45');
        InsertarActividadEconomica('62519', 'Artículos de fotografía y óptica; audífonos', '7', '45');
        InsertarActividadEconomica('62520', 'Artículos y artefactos usados', '7', '45');
        InsertarActividadEconomica('62521', 'Artículos plásticos y de caucho', '7', '45');
        InsertarActividadEconomica('62522', 'Artículos típicos (artesanía)', '7', '45');
        InsertarActividadEconomica('62523', 'Artículos médicos', '7', '45');
        InsertarActividadEconomica('62524', 'Bazares, cordonerías y paqueterías', '7', '45');
        InsertarActividadEconomica('62525', 'Barracas de fierro', '7', '45');
        InsertarActividadEconomica('62526', 'Barracas de madera', '7', '45');
        InsertarActividadEconomica('62527', 'Baldosas', '7', '45');
        InsertarActividadEconomica('62528', 'Bicicletas y sus repuestos', '7', '45');
        InsertarActividadEconomica('62529', 'Casas de música, instrumentos musicales, discos, radios, televisores, etc', '7', '45');
        InsertarActividadEconomica('62530', 'Casas de deportes', '7', '45');
        InsertarActividadEconomica('62531', 'Combustibles sólidos y líquidos (excepto estaciones de servicio)', '7', '45');
        InsertarActividadEconomica('62532', 'Cristalerías, lozas, porcelanas, menajes, etc', '7', '45');
        InsertarActividadEconomica('62534', 'Casas prefabricadas, rodantes', '7', '45');
        InsertarActividadEconomica('62535', 'Arboles y plantas', '7', '45');
        InsertarActividadEconomica('62536', 'Estaciones de servicio (ventas de bencina, lubricantes, servicio de lavado, engrase, etc.)', '7', '45');
        InsertarActividadEconomica('62537', 'Equipo profesional y científico: Instrumentos de medida y control; equipo para seguridad industrial', '7', '45');
        InsertarActividadEconomica('62538', 'Ferreterías y almacenes de pintura, barnices y utensilios para pintores y herramientas en general', '7', '45');
        InsertarActividadEconomica('62541', 'Flores', '7', '45');
        InsertarActividadEconomica('62544', 'Juguetería y venta de juegos infantiles', '7', '45');
        InsertarActividadEconomica('62545', 'Joyerías, relojerías, fantasías', '7', '45');
        InsertarActividadEconomica('62547', 'Librerías, papelerías y artículos de oficina', '7', '45');
        InsertarActividadEconomica('62549', 'Mueblerías', '7', '45');
        InsertarActividadEconomica('62550', 'Máquinas de oficina, cálculo y contabilidad', '7', '45');
        InsertarActividadEconomica('62551', 'Materiales de construcción', '7', '45');
        InsertarActividadEconomica('62552', 'Máquinaria y motores y sus repuestos', '7', '45');
        InsertarActividadEconomica('62553', 'Marcos, cuadros', '7', '45');
        InsertarActividadEconomica('62554', 'Farmacias y Perfumerías', '7', '45');
        InsertarActividadEconomica('62556', 'Sanitarios', '7', '45');
        InsertarActividadEconomica('62557', 'Semillas, abonos y plaguicidas', '7', '45');
        InsertarActividadEconomica('62558', 'Vehículos motorizados y sus repuestos', '7', '45');
        InsertarActividadEconomica('62559', 'Vehículos no motorizados y sus repuestos (excepto bicicletas)', '7', '45');
        InsertarActividadEconomica('62560', 'Yerberías', '7', '45');
        InsertarActividadEconomica('62565', 'Arriendo de cosas muebles (excepto automóviles que va en el 71123 y maquinarias y equipos que va en el 83301)', '7', '45');
        InsertarActividadEconomica('62570', 'Comercio al por menor no clasificado en otra parte', '7', '45');
        //Categoria: RESTAURANTES, CAFES Y OTROS ESTABLECIMIENTOS QUE EXPENDEN COMIDAS Y BEBIDA (8)
        //Subcategoria: RESTAURANTES, CAFES Y OTROS ESTABLECIMIENTOS QUE EXPENDEN COMIDAS Y BEBIDA (46)
        InsertarActividadEconomica('63111', 'Restaurantes, parrilladas, bares, cantinas, clubes, marisquerías, pizzerías, cervecerías, etc', '8', '46');
        InsertarActividadEconomica('63112', 'Salones de té, boite, cabarets, discoteques, drive in, casinos, etc', '8', '46');
        InsertarActividadEconomica('63113', 'Servicios de comida preparada', '8', '46');
        InsertarActividadEconomica('63119', 'Otros establecimientos que expenden comidas y bebidas', '8', '46');
        //Subcategoria: HOTELES, CASAS DE HUÉSPEDES Y OTROS LUGARES DE ALOJAMIENTO (47)
        InsertarActividadEconomica('63211', 'Hoteles, hosterías, moteles, cabañas', '8', '47');
        InsertarActividadEconomica('63212', 'Residenciales y casas de pensión', '8', '47');
        //Categoria: TRANSPORTE, ALMACENAMIENTO Y COMUNICACIONES (9)
        //Subcategoria: TRANSPORTE (48)
        InsertarActividadEconomica('71111', 'Transporte ferroviario y servicios conexos', '9', '48');
        InsertarActividadEconomica('71112', 'Construcción y reparación del material rodante y mantenimiento de infraestructura', '9', '48');
        InsertarActividadEconomica('71121', 'Transporte urbano y suburbano e interurbano', '9', '48');
        InsertarActividadEconomica('71122', 'Explotación de instalaciones conexas', '9', '48');
        InsertarActividadEconomica('71123', 'Arriendo de automoviles', '9', '48');
        InsertarActividadEconomica('71131', 'Otros servicios terrestres de transporte de pasajeros (buses escolares, de turismo, taxis, etc.)', '9', '48');
        InsertarActividadEconomica('71141', 'Transporte de carga por carretera', '9', '48');
        InsertarActividadEconomica('71161', 'Playa y edificios de estacionamientos', '9', '48');
        InsertarActividadEconomica('71211', 'Transporte oceánico o de cabotaje', '9', '48');
        InsertarActividadEconomica('71212', 'Transporte por vías de navegación interior', '9', '48');
        InsertarActividadEconomica('71213', 'Servicio relacionados con el transporte por agua', '9', '48');
        InsertarActividadEconomica('71311', 'Transporte aéreo', '9', '48');
        InsertarActividadEconomica('71312', 'Servicios relacionados', '9', '48');
        //Subcategoria: SERVICIOS CONEXOS (49)
        InsertarActividadEconomica('71911', 'Agencias de turismo (incluye venta de pasajes)', '9', '49');
        InsertarActividadEconomica('71912', 'Agentes de aduana, asesorías en comercio exterior', '9', '49');
        InsertarActividadEconomica('71921', 'Depósitos y almacenamientos y otros servicios conexos (incluye frigoríficos no relacionados con la conservación de carne. Ejemplo: conservación de frutas', '9', '49');
        //Subcategoria: COMUNICACIONES (50)
        InsertarActividadEconomica('72001', 'Comunicaciones', '9', '50');
        //Categoria: FINANZAS, SEGUROS, BIENES INMUEBLES Y SERVICIOS TECNICOS, PROFESIONALES Y OTROS (10)
        //Subcategoria: INSTITUCIONES, AGENCIAS Y SERVICIOS FINANCIEROS (51)
        InsertarActividadEconomica('81011', 'Bancos', '10', '51');
        InsertarActividadEconomica('81021', 'Asociaciones ahorro y préstamo', '10', '51');
        InsertarActividadEconomica('81022', 'Financieras', '10', '51');
        InsertarActividadEconomica('81023', 'Sociedades de inversión y administración de fondos de terceros', '10', '51');
        InsertarActividadEconomica('81024', 'Administradoras de fondos de pensiones', '10', '51');
        InsertarActividadEconomica('81031', 'Casas de cambio y operaciones con divisas, excepto bancos', '10', '51');
        InsertarActividadEconomica('81032', 'Comisionistas de la bolsa', '10', '51');
        InsertarActividadEconomica('81041', 'Rentistas de capitales mobiliarios, cuyo principal ingreso esté constituido por dichas rentas', '10', '51');
        InsertarActividadEconomica('81042', 'Otros servicios financieros (excluye accionistas, que van en el 81041)', '10', '51');
        InsertarActividadEconomica('81049', 'Participación de socios de empresas', '10', '51');
        //Subcategoria: SEGUROS (52)
        InsertarActividadEconomica('82001', 'Compañias de seguros', '10', '52');
        InsertarActividadEconomica('82002', 'Agentes de seguros', '10', '52');
        InsertarActividadEconomica('82003', 'Instituciones de salud previsional, isapres (excluye Cajas de Previsión: 91001)', '10', '52');
        //Subcategoria: EXPLOTACIÓN DE BIENES INMUEBLES (53)
        InsertarActividadEconomica('83101', 'Arrendamiento y administración de bienes inmuebles', '10', '53');
        InsertarActividadEconomica('83102', 'Urbanización y loteos', '10', '53');
        InsertarActividadEconomica('83103', 'Corredores de propiedades', '10', '53');
        //Subcategoria: SERVICIOS TÉCNICOS Y PROFESIONALES QUE TRABAJEN EN FORMA INDEPENDIENTE (54)
        InsertarActividadEconomica('83211', 'Servicios jurídicos (abogados)', '10', '54');
        InsertarActividadEconomica('83212', 'Procuradores', '10', '54');
        InsertarActividadEconomica('83213', 'Notarios públicos', '10', '54');
        InsertarActividadEconomica('83221', 'Servicios de contabilidad y auditorías', '10', '54');
        InsertarActividadEconomica('83222', 'Asesorías tributarias', '10', '54');
        InsertarActividadEconomica('83231', 'Servicios procesamiento de datos y de computación', '10', '54');
        InsertarActividadEconomica('83241', 'Arquitectos', '10', '54');
        InsertarActividadEconomica('83242', 'Constructores', '10', '54');
        InsertarActividadEconomica('83243', 'Dibujantes', '10', '54');
        InsertarActividadEconomica('83244', 'Servicios geológicos y de prospección', '10', '54');
        InsertarActividadEconomica('83245', 'Otros servicios técnicos relacionados con la construcción', '10', '54');
        InsertarActividadEconomica('83251', 'Servicios de publicidad', '10', '54');
        InsertarActividadEconomica('83252', 'Investigación de mercados', '10', '54');
        InsertarActividadEconomica('83261', 'Ingenieros civiles', '10', '54');
        InsertarActividadEconomica('83262', 'Ingenieros comerciales', '10', '54');
        InsertarActividadEconomica('83263', 'Ingenieros de sistemas', '10', '54');
        InsertarActividadEconomica('83264', 'Asesorías económicas, financieras, gerenciales y administrativas (incluye asesorías en comercio exterior)', '10', '54');
        InsertarActividadEconomica('83265', 'Ingenieros agrónomos (Enólogos, Ingenieros de suelos, etc.) ', '10', '54');
        InsertarActividadEconomica('83266', 'Ingenieros calculistas', '10', '54');
        InsertarActividadEconomica('83267', 'Ingenieros mecánicos', '10', '54');
        InsertarActividadEconomica('83268', 'Ingeniero Electrónicos, Eléctricos', '10', '54');
        InsertarActividadEconomica('83269', 'Otros servicios de ingeniería', '10', '54');
        InsertarActividadEconomica('83271', 'Servicios taquimecanografia', '10', '54');
        InsertarActividadEconomica('83272', 'Agencias de empleos', '10', '54');
        InsertarActividadEconomica('83273', 'Diseñadores', '10', '54');
        InsertarActividadEconomica('83291', 'Otros servicios prestados a empresas no especificadas en otra parte', '10', '54');
        InsertarActividadEconomica('83301', 'Alquiler o arrendamiento de maquinaria y equipo', '10', '54');
        //Categoria: SERVICIOS ESTATALES, SOCIALES, PERSONALES E INTERNACIONALES (11)
        //Subcategoria: SERVICIOS ESTATALES, SOCIALES, PERSONALES E INTERNACIONALES (55)
        InsertarActividadEconomica('91001', 'Administración pública y defensa (incluye cajas de previsión)', '11', '55');
        InsertarActividadEconomica('92001', 'Servicios de saneamiento y similares', '11', '55');
        //Categoria: SERVICIOS SOCIALES E INSTRUCCIÓN PÚBLICA (los profesionales y técnicos que son empleados o funcionarios, van en el 95931) (12)
        //Subcategoria: SERVICIOS SOCIALES E INSTRUCCIÓN PÚBLICA (los profesionales y técnicos que son empleados o funcionarios, van en el 95931) (56)
        InsertarActividadEconomica('93101', 'Enseñanza escuelas primarias y secundarias', '12', '56');
        InsertarActividadEconomica('93103', 'Jardines infantiles y parvularios', '12', '56');
        InsertarActividadEconomica('93105', 'Universidades', '12', '56');
        InsertarActividadEconomica('93106', 'Escuelas o institutos técnicos, profesionales o comerciales', '12', '56');
        InsertarActividadEconomica('93107', 'Otras escuelas (de música, de choferes, etc)', '12', '56');
        InsertarActividadEconomica('93110', 'Escuelas de modelos', '12', '56');
        InsertarActividadEconomica('93111', 'Escuelas especializadas; sordomudos, dificultades en el aprendizaje', '12', '56');
        //Subcategoria: INTITUTOS DE INVESTIGACIÓN Y CIENTÍFICOS (57)
        InsertarActividadEconomica('93201', 'Institutos de investigacion de ciencias biológicas, físicas y sociales', '12', '57');
        InsertarActividadEconomica('93202', 'Institutos meteorológicos e investigaciones médicas', '12', '57');
        //Categoria: SERVICIOS MÉDICOS Y ODONTOLÓGICOS; OTROS SERVICIOS DE SANIDAD Y VETERINARIA (13)
        //Subcategoria: SERVICIOS MÉDICOS Y ODONTOLÓGICOS; OTROS SERVICIOS DE SANIDAD Y VETERINARIA (58)
        InsertarActividadEconomica('93311', 'Médicos', '13', '58');
        InsertarActividadEconomica('93312', 'Hospitales, sanatorios, clínicas y otras instituciones similares', '13', '58');
        InsertarActividadEconomica('93313', 'Centros médicos', '13', '58');
        InsertarActividadEconomica('93314', 'Odontólogos', '13', '58');
        InsertarActividadEconomica('93315', 'Laboratorios médicos', '13', '58');
        InsertarActividadEconomica('93316', 'Laboratorios dentales', '13', '58');
        InsertarActividadEconomica('93317', 'Pedicuros (Podólogos)', '13', '58');
        InsertarActividadEconomica('93321', 'Veterinarios', '13', '58');
        InsertarActividadEconomica('93322', 'Clínicas veterinarias', '13', '58');
        InsertarActividadEconomica('93331', 'Ingenieros Químicos, Químicos Farmacéuticos', '13', '58');
        InsertarActividadEconomica('93332', 'Otros profesionales de la salud', '13', '58');
        //Subcategoria: INSTITUCIONES DE ASISTENCIA SOCIAL (59)
        InsertarActividadEconomica('93401', 'Cruz roja, guarderías infantiles, asilos de ancianos, hogares para ciegos y otras instituciones', '13', '59');
        //Subcategoria: ASOCIACIONES COMERCIALES, PROFESIONALES Y LABORALES (60)
        InsertarActividadEconomica('93501', 'Bolsas de Comercio', '13', '60');
        InsertarActividadEconomica('93502', 'Organizaciones profesionales', '13', '60');
        InsertarActividadEconomica('93503', 'Sindicatos', '13', '60');
        InsertarActividadEconomica('93504', 'Colegios profesionales', '13', '60');
        InsertarActividadEconomica('93509', 'Otras asociaciones', '13', '60');
        InsertarActividadEconomica('93910', 'Organizaciones religiosas', '13', '60');
        InsertarActividadEconomica('93991', 'Servicios sociales y comunales conexos, no clasificados en otra parte', '13', '61');
        //Subcategoria: SERVICIOS DE DIVERSIÓN Y ESPARCIMIENTO Y SERVICIOS CULTURALES (61)
        InsertarActividadEconomica('94111', 'Producción de películas cinematográficas', '13', '61');
        InsertarActividadEconomica('94131', 'Emisiones de radio y televisión', '13', '61');
        InsertarActividadEconomica('94141', 'Productores teatrales', '13', '61');
        InsertarActividadEconomica('94143', 'Escenografía e iluminación', '13', '61');
        InsertarActividadEconomica('94144', 'Cines, teatros y distribución de películas cinematográficas', '13', '61');
        InsertarActividadEconomica('94151', 'Autores, compositores y otros artistas independientes, no clasificados en otra parte', '13', '61');
        InsertarActividadEconomica('94161', 'Periodistas', '13', '61');
        InsertarActividadEconomica('94162', 'Agencias periodisticas, de información y noticias', '13', '61');
        InsertarActividadEconomica('94201', 'Bibliotecas, museos, jardines botánicos y zoológicos e instituciones análogas', '13', '61');
        InsertarActividadEconomica('94902', 'Salas de billar, bowling, etc', '13', '61');
        InsertarActividadEconomica('94904', 'Parques y salas de atracciones', '13', '61');
        InsertarActividadEconomica('94905', 'Hipódromos', '13', '61');
        InsertarActividadEconomica('94906', 'Club de deportes, estadios y piscinas', '13', '61');
        InsertarActividadEconomica('94907', 'Ferias de exposición de productos de la industria, agricultura, etc', '13', '64');
        InsertarActividadEconomica('94908', 'Circos, pistas de patinaje y otros servicios de diversión y esparcimiento', '13', '64');
        InsertarActividadEconomica('95111', 'Reparación de calzado y otros articúlos de cuero', '13', '64');
        //Subcategoria: SERVICIOS PERSONALES Y DEL HOGAR (62)
        InsertarActividadEconomica('95121', 'Talleres de reparaciones eléctricas', '13', '64');
        InsertarActividadEconomica('95131', 'Reparación de automóviles y motocicletas', '13', '64');
        InsertarActividadEconomica('95141', 'Reparación de relojes y joyas', '13', '64');
        InsertarActividadEconomica('95191', 'Otros servicios de reparación no clasificados en otra parte', '13', '64');
        InsertarActividadEconomica('95201', 'Lavanderías, lavasecos y tintorerías', '13', '64');
        InsertarActividadEconomica('95202', 'Alquiler de ropa blanca y reparación de ropa y artículos textiles de uso doméstico', '13', '64');
        InsertarActividadEconomica('95301', 'Servicios domésticos', '13', '64');
        InsertarActividadEconomica('95911', 'Peluquerías y salones de belleza', '13', '64');
        InsertarActividadEconomica('95913', 'Salones de masaje, baños turcos, saunas', '13', '64');
        InsertarActividadEconomica('95915', 'Cosmetólogos', '13', '64');
        InsertarActividadEconomica('95921', 'Estudios fotográficos, fotógrafos', '13', '64');
        InsertarActividadEconomica('95931', 'Empleados', '13', '64');
        InsertarActividadEconomica('95932', 'Obreros', '13', '64');
        InsertarActividadEconomica('95934', 'Servicio de buffet y arriendo de locales para matrimonios, fiestas, etc', '13', '64');
        InsertarActividadEconomica('95991', 'Otros servicios personales no clasificados en otra parte', '13', '64');
        InsertarActividadEconomica('95992', 'Pompas fúnebres, cementerios', '13', '64');
        //Subcategoria: ORGANIZACIONES INTERNACIONALES Y OTROS ORGANISMOS EXTRATERRITORIALES (63)
        InsertarActividadEconomica('96001', 'Organismos internacionales y otros organismos extraterritoriales', '13', '62');
    end;

    //-------------------------------------Poblar tabla de código postal
    procedure LlenarTablaDeCodigoPostal()
    begin
        InsertarCodigoPostalChile('01101', 'Iquique', 'CL', 'Iquique');
        InsertarCodigoPostalChile('01107', 'Alto Hospicio', 'CL', 'Iquique');
        InsertarCodigoPostalChile('01401', 'Pozo Almonte', 'CL', 'Tamarugal');
        InsertarCodigoPostalChile('01402', 'Camiña', 'CL', 'Tamarugal');
        InsertarCodigoPostalChile('01403', 'Colchane', 'CL', 'Tamarugal');
        InsertarCodigoPostalChile('01404', 'Huara', 'CL', 'Tamarugal');
        InsertarCodigoPostalChile('01405', 'Pica', 'CL', 'Tamarugal');
        InsertarCodigoPostalChile('02101', 'Antofagasta', 'CL', 'Antofagasta');
        InsertarCodigoPostalChile('02102', 'Mejillones', 'CL', 'Antofagasta');
        InsertarCodigoPostalChile('02103', 'Sierra Gorda', 'CL', 'Antofagasta');
        InsertarCodigoPostalChile('02104', 'Taltal', 'CL', 'Antofagasta');
        InsertarCodigoPostalChile('02201', 'Calama', 'CL', 'El Loa');
        InsertarCodigoPostalChile('02202', 'Ollagüe', 'CL', 'El Loa');
        InsertarCodigoPostalChile('02203', 'San Pedro de Atacama', 'CL', 'El Loa');
        InsertarCodigoPostalChile('02301', 'Tocopilla', 'CL', 'Tocopilla');
        InsertarCodigoPostalChile('02302', 'María Elena', 'CL', 'Tocopilla');
        InsertarCodigoPostalChile('03101', 'Copiapó', 'CL', 'Copiapó');
        InsertarCodigoPostalChile('03102', 'Caldera', 'CL', 'Copiapó');
        InsertarCodigoPostalChile('03103', 'Tierra Amarilla', 'CL', 'Copiapó');
        InsertarCodigoPostalChile('03201', 'Chañaral', 'CL', 'Chañaral');
        InsertarCodigoPostalChile('03202', 'Diego de Almagro', 'CL', 'Chañaral');
        InsertarCodigoPostalChile('03301', 'Vallenar', 'CL', 'Huasco');
        InsertarCodigoPostalChile('03302', 'Alto del Carmen', 'CL', 'Huasco');
        InsertarCodigoPostalChile('03303', 'Freirina', 'CL', 'Huasco');
        InsertarCodigoPostalChile('03304', 'Huasco', 'CL', 'Huasco');
        InsertarCodigoPostalChile('04101', 'La Serena', 'CL', 'El Elqui');
        InsertarCodigoPostalChile('04102', 'Coquimbo', 'CL', 'El Elqui');
        InsertarCodigoPostalChile('04103', 'Andacollo', 'CL', 'El Elqui');
        InsertarCodigoPostalChile('04104', 'La Higuera', 'CL', 'El Elqui');
        InsertarCodigoPostalChile('04105', 'Paihuano', 'CL', 'El Elqui');
        InsertarCodigoPostalChile('04106', 'Vicuña', 'CL', 'El Elqui');
        InsertarCodigoPostalChile('04201', 'Illapel', 'CL', 'Choapa');
        InsertarCodigoPostalChile('04202', 'Canela', 'CL', 'Choapa');
        InsertarCodigoPostalChile('04203', 'Los Vilos', 'CL', 'Choapa');
        InsertarCodigoPostalChile('04204', 'Salamanca', 'CL', 'Choapa');
        InsertarCodigoPostalChile('04301', 'Ovalle', 'CL', 'Limarí');
        InsertarCodigoPostalChile('04302', 'Combarbalá', 'CL', 'Limarí');
        InsertarCodigoPostalChile('04303', 'Monte Patria', 'CL', 'Limarí');
        InsertarCodigoPostalChile('04304', 'Punitaqui', 'CL', 'Limarí');
        InsertarCodigoPostalChile('04305', 'Río Hurtado', 'CL', 'Limarí');
        InsertarCodigoPostalChile('05101', 'Valparaiso', 'CL', 'Valparaíso');
        InsertarCodigoPostalChile('05102', 'Casablanca', 'CL', 'Valparaíso');
        InsertarCodigoPostalChile('05103', 'Concón', 'CL', 'Valparaíso');
        InsertarCodigoPostalChile('05104', 'Juan Fernandez', 'CL', 'Valparaíso');
        InsertarCodigoPostalChile('05105', 'Puchuncaví', 'CL', 'Valparaíso');
        InsertarCodigoPostalChile('05107', 'Quintero', 'CL', 'Valparaíso');
        InsertarCodigoPostalChile('05109', 'Viña del Mar', 'CL', 'Valparaíso');
        InsertarCodigoPostalChile('05201', 'Isla de Pascua', 'CL', 'Isla de Pascua');
        InsertarCodigoPostalChile('05301', 'Los Andes', 'CL', 'Los Andes');
        InsertarCodigoPostalChile('05302', 'Calle Larga', 'CL', 'Los Andes');
        InsertarCodigoPostalChile('05303', 'Rinconada', 'CL', 'Los Andes');
        InsertarCodigoPostalChile('05304', 'San Esteban', 'CL', 'Los Andes');
        InsertarCodigoPostalChile('05401', 'La Ligua', 'CL', 'Petorca');
        InsertarCodigoPostalChile('05402', 'Cabildo', 'CL', 'Petorca');
        InsertarCodigoPostalChile('05403', 'Papudo', 'CL', 'Petorca');
        InsertarCodigoPostalChile('05404', 'Petorca', 'CL', 'Petorca');
        InsertarCodigoPostalChile('05405', 'Zapallar', 'CL', 'Petorca');
        InsertarCodigoPostalChile('05501', 'Quillota', 'CL', 'Quilota');
        InsertarCodigoPostalChile('05502', 'La Calera', 'CL', 'Quilota');
        InsertarCodigoPostalChile('05503', 'Hijuelas', 'CL', 'Quilota');
        InsertarCodigoPostalChile('05504', 'La Cruz', 'CL', 'Quilota');
        InsertarCodigoPostalChile('05506', 'Nogales', 'CL', 'Quilota');
        InsertarCodigoPostalChile('05601', 'San Antonio', 'CL', 'San Antonio');
        InsertarCodigoPostalChile('05602', 'Algarrobo', 'CL', 'San Antonio');
        InsertarCodigoPostalChile('05603', 'Cartagena', 'CL', 'San Antonio');
        InsertarCodigoPostalChile('05604', 'El Quisco', 'CL', 'San Antonio');
        InsertarCodigoPostalChile('05605', 'El Tabo', 'CL', 'San Antonio');
        InsertarCodigoPostalChile('05606', 'Santo Domingo', 'CL', 'San Antonio');
        InsertarCodigoPostalChile('05701', 'San Felipe', 'CL', 'San Felipe de Aconcagua');
        InsertarCodigoPostalChile('05702', 'Catemu', 'CL', 'San Felipe de Aconcagua');
        InsertarCodigoPostalChile('05703', 'Llay-Lay', 'CL', 'San Felipe de Aconcagua');
        InsertarCodigoPostalChile('05704', 'Panquehue', 'CL', 'San Felipe de Aconcagua');
        InsertarCodigoPostalChile('05705', 'Putaendo', 'CL', 'San Felipe de Aconcagua');
        InsertarCodigoPostalChile('05706', 'Santa María', 'CL', 'San Felipe de Aconcagua');
        InsertarCodigoPostalChile('05801', 'Quilpué', 'CL', 'Marga Marga');
        InsertarCodigoPostalChile('05802', 'Limache', 'CL', 'Marga Marga');
        InsertarCodigoPostalChile('05803', 'Olmué', 'CL', 'Marga Marga');
        InsertarCodigoPostalChile('05804', 'Villa Alemana', 'CL', 'Marga Marga');
        InsertarCodigoPostalChile('1000000', 'Arica', 'CL', 'Arica');
        InsertarCodigoPostalChile('1040000', 'Camarones', 'CL', 'Arica');
        InsertarCodigoPostalChile('1070000', 'Putre', 'CL', 'Parinacota');
        InsertarCodigoPostalChile('1080000', 'General lago', 'CL', 'Parinacota');
        InsertarCodigoPostalChile('1100000', 'Iquique', 'CL', 'Iquique');
        InsertarCodigoPostalChile('1130000', 'Alto Hospicio', 'CL', 'Iquique');
        InsertarCodigoPostalChile('1140000', 'Huara', 'CL', 'Tamarugal');
        InsertarCodigoPostalChile('1150000', 'Camiña', 'CL', 'Tamarugal');
        InsertarCodigoPostalChile('1160000', 'Colchane', 'CL', 'Tamarugal');
        InsertarCodigoPostalChile('1170000', 'Pica', 'CL', 'Tamarugal');
        InsertarCodigoPostalChile('1180000', 'Pozo Almonte', 'CL', 'Tamarugal');
        InsertarCodigoPostalChile('1240000', 'Antofagasta', 'CL', 'Antofagasta');
        InsertarCodigoPostalChile('1300000', 'Taltal', 'CL', 'Antofagasta');
        InsertarCodigoPostalChile('1310000', 'Mejillones', 'CL', 'Antofagasta');
        InsertarCodigoPostalChile('13101', 'Santiago', 'CL', 'Santiago');
        InsertarCodigoPostalChile('13102', 'Cerrillos', 'CL', 'Santiago');
        InsertarCodigoPostalChile('13103', 'Cerro Navia', 'CL', 'Santiago');
        InsertarCodigoPostalChile('13104', 'Conchalí', 'CL', 'Santiago');
        InsertarCodigoPostalChile('13105', 'El Bosque', 'CL', 'Santiago');
        InsertarCodigoPostalChile('13106', 'Estación Central', 'CL', 'Santiago');
        InsertarCodigoPostalChile('13107', 'Huechuraba', 'CL', 'Santiago');
        InsertarCodigoPostalChile('13108', 'Independencia', 'CL', 'Santiago');
        InsertarCodigoPostalChile('13109', 'La Cisterna', 'CL', 'Santiago');
        InsertarCodigoPostalChile('13110', 'La Florida', 'CL', 'Santiago');
        InsertarCodigoPostalChile('13111', 'La Granja', 'CL', 'Santiago');
        InsertarCodigoPostalChile('13112', 'La Pintana', 'CL', 'Santiago');
        InsertarCodigoPostalChile('13113', 'La Reina', 'CL', 'Santiago');
        InsertarCodigoPostalChile('13114', 'Las Condes', 'CL', 'Santiago');
        InsertarCodigoPostalChile('13115', 'Lo Barnechea', 'CL', 'Santiago');
        InsertarCodigoPostalChile('13116', 'Lo Espejo', 'CL', 'Santiago');
        InsertarCodigoPostalChile('13117', 'Lo Prado', 'CL', 'Santiago');
        InsertarCodigoPostalChile('13118', 'Macul', 'CL', 'Santiago');
        InsertarCodigoPostalChile('13119', 'Maipú', 'CL', 'Santiago');
        InsertarCodigoPostalChile('13120', 'Ñuñoa', 'CL', 'Santiago');
        InsertarCodigoPostalChile('13121', 'Pedro Aguirre Cerda', 'CL', 'Santiago');
        InsertarCodigoPostalChile('13122', 'Peñalolén', 'CL', 'Santiago');
        InsertarCodigoPostalChile('13123', 'Providencia', 'CL', 'Santiago');
        InsertarCodigoPostalChile('13124', 'Pudahuel', 'CL', 'Santiago');
        InsertarCodigoPostalChile('13125', 'Quilicura', 'CL', 'Santiago');
        InsertarCodigoPostalChile('13126', 'Quinta Normal', 'CL', 'Santiago');
        InsertarCodigoPostalChile('13127', 'Recoleta', 'CL', 'Santiago');
        InsertarCodigoPostalChile('13128', 'Renca', 'CL', 'Santiago');
        InsertarCodigoPostalChile('13129', 'San Joaquín', 'CL', 'Santiago');
        InsertarCodigoPostalChile('13130', 'San Miguel', 'CL', 'Santiago');
        InsertarCodigoPostalChile('13131', 'San Ramón', 'CL', 'Santiago');
        InsertarCodigoPostalChile('13132', 'Vitacura', 'CL', 'Santiago');
        InsertarCodigoPostalChile('1320000', 'Sierra Gorda', 'CL', 'Antofagasta');
        InsertarCodigoPostalChile('13201', 'Puente Alto', 'CL', 'Cordillera');
        InsertarCodigoPostalChile('13202', 'Pirque', 'CL', 'Cordillera');
        InsertarCodigoPostalChile('13203', 'San José de Maipo', 'CL', 'Cordillera');
        InsertarCodigoPostalChile('13301', 'Colina', 'CL', 'Chacabuco');
        InsertarCodigoPostalChile('13302', 'Lampa', 'CL', 'Chacabuco');
        InsertarCodigoPostalChile('13303', 'Til Til', 'CL', 'Chacabuco');
        InsertarCodigoPostalChile('13401', 'San Bernardo', 'CL', 'Maipo');
        InsertarCodigoPostalChile('13402', 'Buin', 'CL', 'Maipo');
        InsertarCodigoPostalChile('13403', 'Calera de Tango', 'CL', 'Maipo');
        InsertarCodigoPostalChile('13404', 'Paine', 'CL', 'Maipo');
        InsertarCodigoPostalChile('13501', 'Melipilla', 'CL', 'Melipilla');
        InsertarCodigoPostalChile('13502', 'Alhué', 'CL', 'Melipilla');
        InsertarCodigoPostalChile('13503', 'Curacaví', 'CL', 'Melipilla');
        InsertarCodigoPostalChile('13504', 'María Pinto', 'CL', 'Melipilla');
        InsertarCodigoPostalChile('13505', 'San Pedro', 'CL', 'Melipilla');
        InsertarCodigoPostalChile('1360000', 'María Elena', 'CL', 'Tocopilla');
        InsertarCodigoPostalChile('1340000', 'Tocopilla', 'CL', 'Tocopilla');
        InsertarCodigoPostalChile('13601', 'Talagante', 'CL', 'Talagante');
        InsertarCodigoPostalChile('13602', 'El Monte', 'CL', 'Talagante');
        InsertarCodigoPostalChile('13603', 'Isla de Maipo', 'CL', 'Talagante');
        InsertarCodigoPostalChile('13604', 'Padre Hurtado', 'CL', 'Talagante');
        InsertarCodigoPostalChile('13605', 'Peñaflor', 'CL', 'Talagante');
        InsertarCodigoPostalChile('1390000', 'Calama', 'CL', 'El Loa');
        InsertarCodigoPostalChile('1410000', 'San Pedro de Atacama', 'CL', 'El Loa');
        InsertarCodigoPostalChile('1420000', 'Ollagüe', 'CL', 'El Loa');
        InsertarCodigoPostalChile('1490000', 'Chañaral', 'CL', 'Chañaral');
        InsertarCodigoPostalChile('1500000', 'Diego de Almagro', 'CL', 'Chañaral');
        InsertarCodigoPostalChile('15101', 'Arica', 'CL', 'Arica');
        InsertarCodigoPostalChile('15102', 'Camarones', 'CL', 'Arica');
        InsertarCodigoPostalChile('15201', 'Putre', 'CL', 'Parinacota');
        InsertarCodigoPostalChile('15202', 'General lago', 'CL', 'Parinacota');
        InsertarCodigoPostalChile('1530000', 'Copiapó', 'CL', 'Copiapó');
        InsertarCodigoPostalChile('1570000', 'Caldera', 'CL', 'Copiapó');
        InsertarCodigoPostalChile('1580000', 'Tierra Amarilla', 'CL', 'Copiapó');
        InsertarCodigoPostalChile('1610000', 'Vallenar', 'CL', 'Huasco');
        InsertarCodigoPostalChile('1630000', 'Freirina', 'CL', 'Huasco');
        InsertarCodigoPostalChile('1640000', 'Huasco', 'CL', 'Huasco');
        InsertarCodigoPostalChile('1650000', 'Alto del Carmen', 'CL', 'Huasco');
        InsertarCodigoPostalChile('1700000', 'La Serena', 'CL', 'El Elqui');
        InsertarCodigoPostalChile('1740000', 'La Higuera', 'CL', 'El Elqui');
        InsertarCodigoPostalChile('1750000', 'Andacollo', 'CL', 'El Elqui');
        InsertarCodigoPostalChile('1760000', 'Vicuña', 'CL', 'El Elqui');
        InsertarCodigoPostalChile('1770000', 'Paihuano', 'CL', 'El Elqui');
        InsertarCodigoPostalChile('1780000', 'Coquimbo', 'CL', 'El Elqui');
        InsertarCodigoPostalChile('1840000', 'Ovalle', 'CL', 'Limarí');
        InsertarCodigoPostalChile('1870000', 'Río Hurtado', 'CL', 'Limarí');
        InsertarCodigoPostalChile('1880000', 'Monte Patria', 'CL', 'Limarí');
        InsertarCodigoPostalChile('1890000', 'Combarbalá', 'CL', 'Limarí');
        InsertarCodigoPostalChile('1900000', 'Punitaqui', 'CL', 'Limarí');
        InsertarCodigoPostalChile('1930000', 'Illapel', 'CL', 'Choapa');
        InsertarCodigoPostalChile('1940000', 'Los Vilos', 'CL', 'Choapa');
        InsertarCodigoPostalChile('1950000', 'Salamanca', 'CL', 'Choapa');
        InsertarCodigoPostalChile('1960000', 'Canela', 'CL', 'Choapa');
        InsertarCodigoPostalChile('2030000', 'La Ligua', 'CL', 'Petorca');
        InsertarCodigoPostalChile('2040000', 'Petorca', 'CL', 'Petorca');
        InsertarCodigoPostalChile('2050000', 'Cabildo', 'CL', 'Petorca');
        InsertarCodigoPostalChile('2060000', 'Zapallar', 'CL', 'Petorca');
        InsertarCodigoPostalChile('2070000', 'Papudo', 'CL', 'Petorca');
        InsertarCodigoPostalChile('2100000', 'Los Andes', 'CL', 'Los Andes');
        InsertarCodigoPostalChile('2120000', 'San Esteban', 'CL', 'Los Andes');
        InsertarCodigoPostalChile('2130000', 'Calle Larga', 'CL', 'Los Andes');
        InsertarCodigoPostalChile('2140000', 'Rinconada', 'CL', 'Los Andes');
        InsertarCodigoPostalChile('2170000', 'San Felipe', 'CL', 'San Felipe de Aconcagua');
        InsertarCodigoPostalChile('2190000', 'Putaendo', 'CL', 'San Felipe de Aconcagua');
        InsertarCodigoPostalChile('2200000', 'Santa María', 'CL', 'San Felipe de Aconcagua');
        InsertarCodigoPostalChile('2210000', 'Panquehue', 'CL', 'San Felipe de Aconcagua');
        InsertarCodigoPostalChile('2220000', 'Llanquihue', 'CL', 'Llanquihue');
        InsertarCodigoPostalChile('2230000', 'Catemu', 'CL', 'San Felipe de Aconcagua');
        InsertarCodigoPostalChile('2240000', 'Limache', 'CL', 'Marga Marga');
        InsertarCodigoPostalChile('2260000', 'Quillota', 'CL', 'Quillota');
        InsertarCodigoPostalChile('2280000', 'La Cruz', 'CL', 'Quillota');
        InsertarCodigoPostalChile('2290000', 'La Calera', 'CL', 'Quillota');
        InsertarCodigoPostalChile('2300000', 'Nogales', 'CL', 'Quillota');
        InsertarCodigoPostalChile('2310000', 'Hijuelas', 'CL', 'Quillota');
        InsertarCodigoPostalChile('2330000', 'Olmué', 'CL', 'Marga Marga');
        InsertarCodigoPostalChile('2340000', 'Valparaiso', 'CL', 'Valparaiso');
        InsertarCodigoPostalChile('2430000', 'Quilpué', 'CL', 'Marga Marga');
        InsertarCodigoPostalChile('2480000', 'Casablanca', 'CL', 'Valparaíso');
        InsertarCodigoPostalChile('2490000', 'Quintero', 'CL', 'Valparaíso');
        InsertarCodigoPostalChile('2500000', 'Puchuncaví', 'CL', 'Valparaíso');
        InsertarCodigoPostalChile('2510000', 'Concón', 'CL', 'Valparaíso');
        InsertarCodigoPostalChile('2520000', 'Viña del Mar', 'CL', 'Valparaíso');
        InsertarCodigoPostalChile('2600000', 'Juan Fernandez', 'CL', 'Valparaíso');
        InsertarCodigoPostalChile('2660000', 'San Antonio', 'CL', 'San Antonio');
        InsertarCodigoPostalChile('2680000', 'Cartagena', 'CL', 'San Antonio');
        InsertarCodigoPostalChile('2690000', 'El Tabo', 'CL', 'San Antonio');
        InsertarCodigoPostalChile('2700000', 'El Quisco', 'CL', 'San Antonio');
        InsertarCodigoPostalChile('2710000', 'Algarrobo', 'CL', 'San Antonio');
        InsertarCodigoPostalChile('2720000', 'Santo Domingo', 'CL', 'San Antonio');
        InsertarCodigoPostalChile('2770000', 'Rapanui', 'CL', 'Isla de Pascua');
        InsertarCodigoPostalChile('2820000', 'Rancagua', 'CL', 'Cachapoal');
        InsertarCodigoPostalChile('2880000', 'Graneros', 'CL', 'Cachapoal');
        InsertarCodigoPostalChile('2890000', 'Mostazal', 'CL', 'Cachapoal');
        InsertarCodigoPostalChile('2900000', 'Codegua', 'CL', 'Cachapoal');
        InsertarCodigoPostalChile('2910000', 'Machalí', 'CL', 'Cachapoal');
        InsertarCodigoPostalChile('2920000', 'Olivar', 'CL', 'Cachapoal');
        InsertarCodigoPostalChile('2930000', 'Requinoa', 'CL', 'Cachapoal');
        InsertarCodigoPostalChile('2940000', 'Rengo', 'CL', 'Cachapoal');
        InsertarCodigoPostalChile('2950000', 'Malloa', 'CL', 'Cachapoal');
        InsertarCodigoPostalChile('2960000', 'Quinta de Tilcoco', 'CL', 'Cachapoal');
        InsertarCodigoPostalChile('2970000', 'San Vicente', 'CL', 'Cachapoal');
        InsertarCodigoPostalChile('2980000', 'Pichidegua', 'CL', 'Cachapoal');
        InsertarCodigoPostalChile('2990000', 'Peumo', 'CL', 'Cachapoal');
        InsertarCodigoPostalChile('3000000', 'Coltauco', 'CL', 'Cachapoal');
        InsertarCodigoPostalChile('3010000', 'Coinco', 'CL', 'Cachapoal');
        InsertarCodigoPostalChile('3020000', 'Doñihue', 'CL', 'Cachapoal');
        InsertarCodigoPostalChile('3030000', 'Las Cabras', 'CL', 'Cachapoal');
        InsertarCodigoPostalChile('3070000', 'San Fernando', 'CL', 'Colchagua');
        InsertarCodigoPostalChile('3090000', 'Chimbarongo', 'CL', 'Colchagua');
        InsertarCodigoPostalChile('3100000', 'Placilla', 'CL', 'Colchagua');
        InsertarCodigoPostalChile('3110000', 'Rancagua', 'CL', 'Colchagua');
        InsertarCodigoPostalChile('3120000', 'Chépica', 'CL', 'Colchagua');
        InsertarCodigoPostalChile('3130000', 'Santa Cruz', 'CL', 'Colchagua');
        InsertarCodigoPostalChile('3140000', 'Lolol', 'CL', 'Colchagua');
        InsertarCodigoPostalChile('3150000', 'Pumanque', 'CL', 'Colchagua');
        InsertarCodigoPostalChile('3160000', 'Palmilla', 'CL', 'Colchagua');
        InsertarCodigoPostalChile('3170000', 'Peralillo', 'CL', 'Colchagua');
        InsertarCodigoPostalChile('3220000', 'Pichilemu', 'CL', 'Colchagua');
        InsertarCodigoPostalChile('3230000', 'Navidad', 'CL', 'Cardenal Caro');
        InsertarCodigoPostalChile('3240000', 'Litueche', 'CL', 'Cardenal Caro');
        InsertarCodigoPostalChile('3250000', 'La Estrella', 'CL', 'Cardenal Caro');
        InsertarCodigoPostalChile('3260000', 'Marchihue', 'CL', 'Cardenal Caro');
        InsertarCodigoPostalChile('3270000', 'Paredones', 'CL', 'Cardenal Caro');
        InsertarCodigoPostalChile('3340000', 'Curicó', 'CL', 'Curicó');
        InsertarCodigoPostalChile('3360000', 'Teno', 'CL', 'Curicó');
        InsertarCodigoPostalChile('3370000', 'Romeral', 'CL', 'Curicó');
        InsertarCodigoPostalChile('3380000', 'Molino', 'CL', 'Curicó');
        InsertarCodigoPostalChile('3390000', 'Sagrada Familia', 'CL', 'Curicó');
        InsertarCodigoPostalChile('3400000', 'Hualañé', 'CL', 'Curicó');
        InsertarCodigoPostalChile('3410000', 'Licantén', 'CL', 'Curicó');
        InsertarCodigoPostalChile('3420000', 'Vichuquén', 'CL', 'Curicó');
        InsertarCodigoPostalChile('3430000', 'Rauco', 'CL', 'Curicó');
        InsertarCodigoPostalChile('3460000', 'Talca', 'CL', 'Talca');
        InsertarCodigoPostalChile('3490000', 'San Rafael', 'CL', 'Talca');
        InsertarCodigoPostalChile('3500000', 'Pelarco', 'CL', 'Talca');
        InsertarCodigoPostalChile('3510000', 'Rio Claro', 'CL', 'Talca');
        InsertarCodigoPostalChile('3520000', 'San Clemente', 'CL', 'Talca');
        InsertarCodigoPostalChile('3530000', 'Maule', 'CL', 'Talca');
        InsertarCodigoPostalChile('3540000', 'Empedrado', 'CL', 'Talca');
        InsertarCodigoPostalChile('3550000', 'Pencahue', 'CL', 'Talca');
        InsertarCodigoPostalChile('3560000', 'Constitución', 'CL', 'Talca');
        InsertarCodigoPostalChile('3570000', 'Curepto', 'CL', 'Talca');
        InsertarCodigoPostalChile('3580000', 'Linares', 'CL', 'Linares');
        InsertarCodigoPostalChile('3600000', 'Yerbas Buenas', 'CL', 'Linares');
        InsertarCodigoPostalChile('3610000', 'Colbún', 'CL', 'Linares');
        InsertarCodigoPostalChile('3620000', 'Longaví', 'CL', 'Linares');
        InsertarCodigoPostalChile('3630000', 'Parral', 'CL', 'Linares');
        InsertarCodigoPostalChile('3640000', 'Retiro', 'CL', 'Linares');
        InsertarCodigoPostalChile('3650000', 'Villa Alegre', 'CL', 'Linares');
        InsertarCodigoPostalChile('3660000', 'San Javier', 'CL', 'Linares');
        InsertarCodigoPostalChile('3690000', 'Cauquenes', 'CL', 'Cauquenes');
        InsertarCodigoPostalChile('3710000', 'Pelluhue', 'CL', 'Cauquenes');
        InsertarCodigoPostalChile('3720000', 'Chanco', 'CL', 'Cauquenes');
        InsertarCodigoPostalChile('3780000', 'Chillán', 'CL', 'Ñuble');
        InsertarCodigoPostalChile('3820000', 'Chillán Viejo', 'CL', 'Ñuble');
        InsertarCodigoPostalChile('3840000', 'San Carlos', 'CL', 'Ñuble');
        InsertarCodigoPostalChile('3850000', 'Ñiquén', 'CL', 'Ñuble');
        InsertarCodigoPostalChile('3860000', 'San Fabian', 'CL', 'Ñuble');
        InsertarCodigoPostalChile('3870000', 'Coihueco', 'CL', 'Ñuble');
        InsertarCodigoPostalChile('3880000', 'Pinto', 'CL', 'Ñuble');
        InsertarCodigoPostalChile('3890000', 'San Ignacio', 'CL', 'Ñuble');
        InsertarCodigoPostalChile('3900000', 'El Carmen', 'CL', 'Ñuble');
        InsertarCodigoPostalChile('3910000', 'Pemuco', 'CL', 'Ñuble');
        InsertarCodigoPostalChile('3920000', 'Yungay', 'CL', 'Ñuble');
        InsertarCodigoPostalChile('3930000', 'Bulnes', 'CL', 'Ñuble');
        InsertarCodigoPostalChile('3940000', 'Quillón', 'CL', 'Ñuble');
        InsertarCodigoPostalChile('3950000', 'Ranquil', 'CL', 'Ñuble');
        InsertarCodigoPostalChile('3960000', 'Portezuelo', 'CL', 'Ñuble');
        InsertarCodigoPostalChile('3970000', 'Coelemu', 'CL', 'Ñuble');
        InsertarCodigoPostalChile('3980000', 'Trehuaco', 'CL', 'Ñuble');
        InsertarCodigoPostalChile('3990000', 'Cobquecura', 'CL', 'Ñuble');
        InsertarCodigoPostalChile('4000000', 'Quirihue', 'CL', 'Ñuble');
        InsertarCodigoPostalChile('4010000', 'Ninhue', 'CL', 'Ñuble');
        InsertarCodigoPostalChile('4020000', 'San Nicolás', 'CL', 'Ñuble');
        InsertarCodigoPostalChile('4030000', 'Concepción', 'CL', 'Concepción');
        InsertarCodigoPostalChile('4100000', 'Chiguayante', 'CL', 'Concepción');
        InsertarCodigoPostalChile('4130000', 'San Pedro de la Paz', 'CL', 'Concepción');
        InsertarCodigoPostalChile('4150000', 'Penco', 'CL', 'Concepción');
        InsertarCodigoPostalChile('4160000', 'Tomé', 'CL', 'Concepción');
        InsertarCodigoPostalChile('4170000', 'Florida', 'CL', 'Concepción');
        InsertarCodigoPostalChile('4180000', 'Hualqui', 'CL', 'Concepción');
        InsertarCodigoPostalChile('4190000', 'Coronel', 'CL', 'Concepción');
        InsertarCodigoPostalChile('4210000', 'Lota', 'CL', 'Concepción');
        InsertarCodigoPostalChile('4230000', 'Santa Juana', 'CL', 'Concepción');
        InsertarCodigoPostalChile('4260000', 'Talcahuano', 'CL', 'Concepción');
        InsertarCodigoPostalChile('4350000', 'Lebu', 'CL', 'Arauco');
        InsertarCodigoPostalChile('4360000', 'Arauco', 'CL', 'Arauco');
        InsertarCodigoPostalChile('4370000', 'Curanilahue', 'CL', 'Arauco');
        InsertarCodigoPostalChile('4380000', 'Los Alamos', 'CL', 'Arauco');
        InsertarCodigoPostalChile('4390000', 'Cañete', 'CL', 'Arauco');
        InsertarCodigoPostalChile('4400000', 'Contulmo', 'CL', 'Arauco');
        InsertarCodigoPostalChile('4410000', 'Tirua', 'CL', 'Arauco');
        InsertarCodigoPostalChile('4440000', 'Los Angeles', 'CL', 'Biobío');
        InsertarCodigoPostalChile('4470000', 'Cabrero', 'CL', 'Biobío');
        InsertarCodigoPostalChile('4480000', 'Tucapel', 'CL', 'Biobío');
        InsertarCodigoPostalChile('4490000', 'Antuco', 'CL', 'Biobío');
        InsertarCodigoPostalChile('4500000', 'Quilleco', 'CL', 'Biobío');
        InsertarCodigoPostalChile('4510000', 'Santa Barbara', 'CL', 'Biobío');
        InsertarCodigoPostalChile('4520000', 'Quilaco', 'CL', 'Biobío');
        InsertarCodigoPostalChile('4530000', 'Mulchén', 'CL', 'Biobío');
        InsertarCodigoPostalChile('4540000', 'Negrete', 'CL', 'Biobío');
        InsertarCodigoPostalChile('4550000', 'Nacimiento', 'CL', 'Biobío');
        InsertarCodigoPostalChile('4560000', 'Laja', 'CL', 'Biobío');
        InsertarCodigoPostalChile('4570000', 'San Rosendo', 'CL', 'Biobío');
        InsertarCodigoPostalChile('4580000', 'Yumbel', 'CL', 'Biobío');
        InsertarCodigoPostalChile('4590000', 'Alto Biobío', 'CL', 'Biobío');
        InsertarCodigoPostalChile('4600000', 'Hualpén', 'CL', 'Concepción');
        InsertarCodigoPostalChile('4650000', 'Angol', 'CL', 'Malleco');
        InsertarCodigoPostalChile('4670000', 'Reinaco', 'CL', 'Malleco');
        InsertarCodigoPostalChile('4680000', 'Collipulli', 'CL', 'Malleco');
        InsertarCodigoPostalChile('4690000', 'Lonquimay', 'CL', 'Malleco');
        InsertarCodigoPostalChile('4700000', 'Curacautín', 'CL', 'Malleco');
        InsertarCodigoPostalChile('4710000', 'Ercilla', 'CL', 'Malleco');
        InsertarCodigoPostalChile('4720000', 'Victoria', 'CL', 'Malleco');
        InsertarCodigoPostalChile('4730000', 'Traiguén', 'CL', 'Malleco');
        InsertarCodigoPostalChile('4740000', 'Lumaco', 'CL', 'Malleco');
        InsertarCodigoPostalChile('4750000', 'Purén', 'CL', 'Malleco');
        InsertarCodigoPostalChile('4760000', 'Los Sauces', 'CL', 'Malleco');
        InsertarCodigoPostalChile('4780000', 'Temuco', 'CL', 'Cautín');
        InsertarCodigoPostalChile('4850000', 'Padre Las Casas', 'CL', 'Cautín');
        InsertarCodigoPostalChile('4860000', 'lautaro', 'CL', 'Cautín');
        InsertarCodigoPostalChile('4870000', 'Perquenco', 'CL', 'Cautín');
        InsertarCodigoPostalChile('4880000', 'Vilcún', 'CL', 'Cautín');
        InsertarCodigoPostalChile('4890000', 'Cunco', 'CL', 'Cautín');
        InsertarCodigoPostalChile('4900000', 'Melipeuco', 'CL', 'Cautín');
        InsertarCodigoPostalChile('4910000', 'Cirarrehue', 'CL', 'Cautín');
        InsertarCodigoPostalChile('4920000', 'Pucón', 'CL', 'Cautín');
        InsertarCodigoPostalChile('4930000', 'Villa Rica', 'CL', 'Cautín');
        InsertarCodigoPostalChile('4940000', 'Freire', 'CL', 'Cautín');
        InsertarCodigoPostalChile('4950000', 'Pitrufquén', 'CL', 'Cautín');
        InsertarCodigoPostalChile('4960000', 'Gorbea', 'CL', 'Cautín');
        InsertarCodigoPostalChile('4970000', 'Loncoche', 'CL', 'Cautín');
        InsertarCodigoPostalChile('4980000', 'Toltén', 'CL', 'Cautín');
        InsertarCodigoPostalChile('4990000', 'Teodro Schmidt', 'CL', 'Cautín');
        InsertarCodigoPostalChile('5000000', 'Saavedra', 'CL', 'Cautín');
        InsertarCodigoPostalChile('5010000', 'Carahue', 'CL', 'Cautín');
        InsertarCodigoPostalChile('5020000', 'Nueva Imperial', 'CL', 'Cautín');
        InsertarCodigoPostalChile('5030000', 'Galvarino', 'CL', 'Cautín');
        InsertarCodigoPostalChile('5040000', 'Cholchol', 'CL', 'Cautín');
        InsertarCodigoPostalChile('5090000', 'Valdivia', 'CL', 'Valdivia');
        InsertarCodigoPostalChile('5150000', 'Mariquina', 'CL', 'Valdivia');
        InsertarCodigoPostalChile('5160000', 'Lanco', 'CL', 'Valdivia');
        InsertarCodigoPostalChile('5170000', 'Los Lagos', 'CL', 'Valdivia');
        InsertarCodigoPostalChile('5180000', 'Futrono', 'CL', 'Provincia del Ranco');
        InsertarCodigoPostalChile('5190000', 'Corral', 'CL', 'Valdivia');
        InsertarCodigoPostalChile('5200000', 'Máfil', 'CL', 'Valdivia');
        InsertarCodigoPostalChile('5210000', 'Panguipulli', 'CL', 'Valdivia');
        InsertarCodigoPostalChile('5220000', 'Lago Ranco', 'CL', 'Provincia del Ranco');
        InsertarCodigoPostalChile('5230000', 'Paillaco', 'CL', 'Valdivia');
        InsertarCodigoPostalChile('5240000', 'Rio Bueno', 'CL', 'Provincia del Ranco');
        InsertarCodigoPostalChile('5250000', 'La Unión', 'CL', 'Provincia del Ranco');
        InsertarCodigoPostalChile('5290000', 'Osorno', 'CL', 'Osorno');
        InsertarCodigoPostalChile('5350000', 'San Pablo', 'CL', 'Osorno');
        InsertarCodigoPostalChile('5360000', 'Puyehue', 'CL', 'Osorno');
        InsertarCodigoPostalChile('5370000', 'Puerto Octay', 'CL', 'Osorno');
        InsertarCodigoPostalChile('5380000', 'Purranque', 'CL', 'Osorno');
        InsertarCodigoPostalChile('5390000', 'Río Negro', 'CL', 'Osorno');
        InsertarCodigoPostalChile('5400000', 'San Juan de la Costa', 'CL', 'Osorno');
        InsertarCodigoPostalChile('5480000', 'Puerto Montt', 'CL', 'Llanquihue');
        InsertarCodigoPostalChile('5550000', 'Puerto Varas', 'CL', 'Llanquihue');
        InsertarCodigoPostalChile('5560000', 'Cochamó', 'CL', 'Llanquihue');
        InsertarCodigoPostalChile('5570000', 'Calbuco', 'CL', 'Llanquihue');
        InsertarCodigoPostalChile('5580000', 'Maullín', 'CL', 'Llanquihue');
        InsertarCodigoPostalChile('5590000', 'Los Muermos', 'CL', 'Llanquihue');
        InsertarCodigoPostalChile('5600000', 'Fresia', 'CL', 'Llanquihue');
        InsertarCodigoPostalChile('5610000', 'Llay-Lay', 'CL', 'San Felipe de Aconcagua');
        InsertarCodigoPostalChile('5620000', 'Frutillar', 'CL', 'Llanquihue');
        InsertarCodigoPostalChile('5700000', 'Castro', 'CL', 'Chiloé');
        InsertarCodigoPostalChile('5710000', 'Ancud', 'CL', 'Chiloé');
        InsertarCodigoPostalChile('5720000', 'Quemchi', 'CL', 'Chiloé');
        InsertarCodigoPostalChile('5730000', 'Dalcahue', 'CL', 'Chiloé');
        InsertarCodigoPostalChile('5740000', 'Curaco de Vélez', 'CL', 'Chiloé');
        InsertarCodigoPostalChile('5750000', 'Quinchao', 'CL', 'Chiloé');
        InsertarCodigoPostalChile('5760000', 'Puqueldón', 'CL', 'Chiloé');
        InsertarCodigoPostalChile('5770000', 'Chonchi', 'CL', 'Chiloé');
        InsertarCodigoPostalChile('5780000', 'Queilén', 'CL', 'Chiloé');
        InsertarCodigoPostalChile('5790000', 'Quellón', 'CL', 'Chiloé');
        InsertarCodigoPostalChile('5850000', 'Chaitén', 'CL', 'Osorno');
        InsertarCodigoPostalChile('5860000', 'Hualaihue', 'CL', 'Osorno');
        InsertarCodigoPostalChile('5870000', 'Futaleufú', 'CL', 'Osorno');
        InsertarCodigoPostalChile('5880000', 'Palena', 'CL', 'Osorno');
        InsertarCodigoPostalChile('5950000', 'Coyhaique', 'CL', 'Coyhaique');
        InsertarCodigoPostalChile('5960000', 'Lago Verde', 'CL', 'Coyhaique');
        InsertarCodigoPostalChile('6000000', 'Aysén', 'CL', 'Aysén');
        InsertarCodigoPostalChile('6010000', 'Cisnes', 'CL', 'Aysén');
        InsertarCodigoPostalChile('6020000', 'Guaitecas', 'CL', 'Aysén');
        InsertarCodigoPostalChile('6050000', 'Chile Chico', 'CL', 'General Carrera');
        InsertarCodigoPostalChile('6060000', 'Río Ibáñez', 'CL', 'General Carrera');
        InsertarCodigoPostalChile('6100000', 'Cochrane', 'CL', 'Capitán Prat');
        InsertarCodigoPostalChile('6110000', 'OHiggins', 'CL', 'Capitán Prat');
        InsertarCodigoPostalChile('6120000', 'Tortel', 'CL', 'Capitán Prat');
        InsertarCodigoPostalChile('6160000', 'Natales', 'CL', 'Última Esperanza');
        InsertarCodigoPostalChile('6170000', 'Torres del Paine', 'CL', 'Última Esperanza');
        InsertarCodigoPostalChile('6200000', 'Punta Arenas', 'CL', 'Magallanes');
        InsertarCodigoPostalChile('6240000', 'Río Verde', 'CL', 'Magallanes');
        InsertarCodigoPostalChile('6250000', 'Laguna Blanca', 'CL', 'Magallanes');
        InsertarCodigoPostalChile('6260000', 'San Gregorio', 'CL', 'Magallanes');
        InsertarCodigoPostalChile('6300000', 'Porvenir', 'CL', 'Tierra del Fuego');
        InsertarCodigoPostalChile('6310000', 'Primavera', 'CL', 'Tierra del Fuego');
        InsertarCodigoPostalChile('6320000', 'Timaukel', 'CL', 'Tierra del Fuego');
        InsertarCodigoPostalChile('6350000', 'Cabo de Hornos', 'CL', 'Antártica Chilena');
        InsertarCodigoPostalChile('6360000', 'Antártica', 'CL', 'Antártica Chilena');
        InsertarCodigoPostalChile('6500000', 'Villa Alemana', 'CL', 'Marga Marga');
        InsertarCodigoPostalChile('7500000', 'Providencia', 'CL', 'Santiago');//
        InsertarCodigoPostalChile('7550000', 'Las Condes', 'CL', 'Santiago');
        InsertarCodigoPostalChile('7630000', 'Vitacura', 'CL', 'Santiago');
        InsertarCodigoPostalChile('7690000', 'Lo Barnechea', 'CL', 'Santiago');
        InsertarCodigoPostalChile('7750000', 'Ñuñoa', 'CL', 'Santiago');
        InsertarCodigoPostalChile('7810000', 'Macul', 'CL', 'Santiago');
        InsertarCodigoPostalChile('7850000', 'La Reina', 'CL', 'Santiago');
        InsertarCodigoPostalChile('7910000', 'Peañalolén', 'CL', 'Santiago');
        InsertarCodigoPostalChile('7970000', 'La Cisterna', 'CL', 'Santiago');
        InsertarCodigoPostalChile('8010000', 'El Bosque', 'CL', 'Santiago');
        InsertarCodigoPostalChile('8050000', 'San Bernardo', 'CL', 'Maipo');
        InsertarCodigoPostalChile('8150000', 'Puente Alto', 'CL', 'Cordillera');
        InsertarCodigoPostalChile('8240000', 'La Florida', 'CL', 'Santiago');
        InsertarCodigoPostalChile('8320000', 'Santiago', 'CL', 'Santiago');
        InsertarCodigoPostalChile('8380000', 'Independencia', 'CL', 'Santiago');
        InsertarCodigoPostalChile('8420000', 'Recoleta', 'CL', 'Santiago');
        InsertarCodigoPostalChile('8460000', 'Pedro Aguirre Cerda', 'CL', 'Santiago');
        InsertarCodigoPostalChile('8500000', 'Quinta Normal', 'CL', 'Santiago');
        InsertarCodigoPostalChile('8540000', 'Conchalí', 'CL', 'Santiago');
        InsertarCodigoPostalChile('8580000', 'Huechuraba', 'CL', 'Santiago');
        InsertarCodigoPostalChile('8640000', 'Renca', 'CL', 'Santiago');
        InsertarCodigoPostalChile('8700000', 'Quilicura', 'CL', 'Santiago');
        InsertarCodigoPostalChile('8780000', 'La Granja', 'CL', 'Santiago');
        InsertarCodigoPostalChile('8820000', 'La Pintana', 'CL', 'Santiago');
        InsertarCodigoPostalChile('8860000', 'San Ramón', 'CL', 'Santiago');
        InsertarCodigoPostalChile('8900000', 'San Miguel', 'CL', 'Santiago');
        InsertarCodigoPostalChile('8940000', 'San Joaquín', 'CL', 'Santiago');
        InsertarCodigoPostalChile('8980000', 'Lo Prado', 'CL', 'Santiago');
        InsertarCodigoPostalChile('9020000', 'Pudahuel', 'CL', 'Santiago');
        InsertarCodigoPostalChile('9080000', 'Cerro Navia', 'CL', 'Santiago');
        InsertarCodigoPostalChile('9120000', 'Lo Espejo', 'CL', 'Santiago');
        InsertarCodigoPostalChile('9160000', 'Estación Central', 'CL', 'Santiago');
        InsertarCodigoPostalChile('9200000', 'Cerrillos', 'CL', 'Santiago');
        InsertarCodigoPostalChile('9250000', 'Maipú', 'CL', 'Santiago');
        InsertarCodigoPostalChile('9340000', 'Colina', 'CL', 'Chacabuco');
        InsertarCodigoPostalChile('9380000', 'Lampa', 'CL', 'Chacabuco');
        InsertarCodigoPostalChile('9420000', 'Til Til', 'CL', 'Chacabuco');
        InsertarCodigoPostalChile('9460000', 'Buin', 'CL', 'Maipo');
        InsertarCodigoPostalChile('9460000', 'San José de Maipo', 'CL', 'Cordillera');
        InsertarCodigoPostalChile('9480000', 'Pirque', 'CL', 'Cordillera');
        InsertarCodigoPostalChile('9500000', 'Buin', 'CL', 'Maipo');//Buin
        InsertarCodigoPostalChile('9540000', 'Paine', 'CL', 'Maipo');
        InsertarCodigoPostalChile('9560000', 'Calera de Tango', 'CL', 'Maipo');
        InsertarCodigoPostalChile('9580000', 'Melipilla', 'CL', 'Melipilla');
        InsertarCodigoPostalChile('9620000', 'María Pinto', 'CL', 'Melipilla');
        InsertarCodigoPostalChile('9630000', 'Curacaví', 'CL', 'Melipilla');
        InsertarCodigoPostalChile('9650000', 'Alhué', 'CL', 'Melipilla');
        InsertarCodigoPostalChile('9660000', 'San Pedro', 'CL', 'Melipilla');
        InsertarCodigoPostalChile('9670000', 'Talagante', 'CL', 'Talagante');
        InsertarCodigoPostalChile('9710000', 'Padre Hurtado', 'CL', 'Talagante');
        InsertarCodigoPostalChile('9750000', 'Peñaflor', 'CL', 'Talagante');
        InsertarCodigoPostalChile('9790000', 'Isla de Maipo', 'CL', 'Talagante');
        InsertarCodigoPostalChile('9810000', 'El Monte', 'CL', 'Talagante');
    end;





    //--------------------------------------Inserción de datos a tablas
    local procedure InsertarCategoriaActividadEconomica(arg1: Text; arg2: Text);//---Agregar valores a tablas.
    var
        STAB: Record CategoriaActividadEconomica;
    begin
        STAB.Init();
        STAB.codigo_Categoria := arg1;
        STAB.nombreCategoria := arg2;
        STAB.Insert();
    end;

    local procedure InsertarSubcategoriaActividadEconomica(arg1: Text; arg2: Text; arg3: Text);
    var
        STAB: Record SubCategoriaActividad;
    begin
        STAB.Init();
        STAB.codigo_Subcategoria := arg1;
        STAB.nombreSubCategorias := arg2;
        STAB.Codigo_Categoria := arg3;
        STAB.Insert();
    end;


    local procedure InsertarActividadEconomica(arg1: Text; arg2: Text; arg3: Text; arg4: Text);
    var
        STAB: Record actividadEconomica;
    begin
        STAB.Init();
        STAB.codigoActividad := arg1;
        STAB.nombre_Actividad := arg2;
        STAB.Subcategoria_Economica := arg4;
        STAB.Categoria_Economica := arg3;
        STAB.Insert();
    end;

    local procedure InsertarTipoBanco(arg1: Text; arg2: Text; arg3: Text)
    var
        STAB: Record tipoBanco;
    begin
        STAB.Init();
        STAB.Codigo_Tipo_Banco := arg1;
        STAB.nombreBanco := arg2;
        STAB.descripcionTipoBanco := arg3;
        STAB.Insert();
    end;

    local procedure InsertarBanco(arg1: Text; arg2: Text; arg3: Text)
    var
        STAB: Record Bancos;
    begin
        STAB.Init();
        STAB.codigoBanco := arg1;
        STAB.nombreBanco := arg2;
        STAB.Opcion_Tipo_Banco := arg3;
        STAB.Insert();
    end;

    local procedure InsertarTipoDocumentos(arg1: Text; arg2: Text)
    var
        STAB: Record tipoDocumentos;
    begin
        STAB.Init();
        STAB.DTE := arg1;
        STAB.Tipo := arg2;
        STAB.Insert();
    end;


    local procedure InsertarTipoTransaccion(arg1: Text; arg2: Text)
    var
        STAB: Record tipoTransaccion;
    begin
        STAB.Init();
        STAB.Id_Transaccion := arg1;
        STAB.descripcionTransaccion := arg2;
        STAB.Insert();
    end;


    local procedure InsertarCodigoPostalChile(arg1: Text; arg2: Text; arg3: Text; arg4: Text)
    var
        STAB: Record "Post Code";
    begin
        STAB.Init();
        STAB.Code := arg1;
        STAB.County := arg2;
        STAB."Country/Region Code" := arg3;
        STAB.City := arg4;
        STAB.Insert();
    end;
}


