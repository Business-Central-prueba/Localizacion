codeunit 50102 XMLTstingActividadEconomica
{
    procedure ImportarXMLDataActividadEconomica()
    var
        FromFile: Text;
        Instr: InStream;
        XmlDoc: XmlDocument;
        Tab: XmlElement;
        NodeList: XmlNodeList;
        NodeListSec: XmlNodeList;
        Node1: XmlNode;
        Node2: XmlNode;
        ActividadEconomica: Record actividadEconomica;
        Element: XmlElement;
        b: Integer;
    begin
        if UploadIntoStream('Subir contenido XML', '', '', FromFile, Instr) then
            XmlDocument.ReadFrom(Instr, XmlDoc)
        else
            Error('No hay archivo XML o se ha cancelado la operación');

        if XmlDoc.GetRoot(Tab) then
            NodeList := Tab.GetChildElements();

        foreach Node1 in NodeList do begin
            ActividadEconomica.Init();
            Element := Node1.AsXmlElement();
            NodeListSec := Element.GetChildElements();
            foreach Node2 in NodeListSec do begin
                case Node2.AsXmlElement().Name of
                    'codigoActividad':
                        ActividadEconomica.Validate(ActividadEconomica.codigoActividad, Node2.AsXmlElement().InnerText);
                    'nombreActividad':
                        ActividadEconomica.Validate(ActividadEconomica.nombre_Actividad, Node2.AsXmlElement().InnerText);
                    'categoriaActividad':
                        ActividadEconomica.Validate(ActividadEconomica.Categoria_Economica, Node2.AsXmlElement().InnerText);
                    'subCategoriaActividad':
                        ActividadEconomica.Validate(ActividadEconomica.Subcategoria_Economica, Node2.AsXmlElement().InnerText);
                end;
            end;
            ActividadEconomica.Insert(true);
        end;
    end;



    //------------------------------------Metodo para exportar XML
    procedure XMLExportarActividadesEconomicas()
    var
        XMLDoc: XmlDocument;
        XMLDec: XmlDeclaration;
        RootNode: XmlElement;
        ActividadEconomica: Record actividadEconomica;
        ParentNode: XmlElement;
        FieldCaption: Text;
        XMLTxt: XmlText;
        ChildNode: XmlElement;
        TempBlob: Codeunit "Temp Blob";
        Instr: InStream;
        Outstr: OutStream;
        ReadTxt: Text;
        WriteTxt: Text;
    begin
        XMLDoc := XmlDocument.Create();
        XMLDec := XmlDeclaration.Create('1.0', 'UTF-8', '');
        XmlDoc.SetDeclaration(XMLDec);
        RootNode := XmlElement.Create('Table');
        XMLDoc.Add(RootNode);
        ActividadEconomica.FindSet();

        repeat

            ParentNode := XmlElement.Create('ActividadEconomica');
            RootNode.add(ParentNode);
            //FieldCaption := Cust.FieldCaption("No.");
            FieldCaption := 'codigoActividad';
            //Message(FieldCaption);
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(ActividadEconomica.codigoActividad);
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);



            //FieldCaption := ActividadEconomica.FieldCaption(nombreActividad);
            FieldCaption := 'nombreActividad';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(ActividadEconomica.nombre_Actividad);
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);



            //FieldCaption := ActividadEconomica.FieldCaption(categoriaActividad);
            FieldCaption := 'categoriaActividad';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(ActividadEconomica.Categoria_Economica));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);


            //FieldCaption := ActividadEconomica.FieldCaption(subCategoriaActividad);
            FieldCaption := 'subCategoriaActividad';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(ActividadEconomica.Subcategoria_Economica));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

        until ActividadEconomica.Next() = 0;

        TempBlob.CreateInStream(Instr);
        TempBlob.CreateOutStream(Outstr);
        XMLDoc.WriteTo(Outstr);
        Outstr.WriteText(WriteTxt);
        Instr.ReadText(WriteTxt);
        ReadTxt := 'LocalizacionChile_ActividadesEconomica.XML';
        DownloadFromStream(Instr, '', '', '', ReadTxt);
        Message('Se ha descargado correctamente el XML de Actividades Economica');
    end;
}