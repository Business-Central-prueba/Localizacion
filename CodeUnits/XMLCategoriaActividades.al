codeunit 50104 XMLTstingCategoriaActividad
{
    procedure ImportarXMLDataCategoriaActividad()
    var
        FromFile: Text;
        Instr: InStream;
        XmlDoc: XmlDocument;
        Tab: XmlElement;
        NodeList: XmlNodeList;
        NodeListSec: XmlNodeList;
        Node1: XmlNode;
        Node2: XmlNode;
        CategoriaActividadEconomica: Record CategoriaActividadEconomica;
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
            CategoriaActividadEconomica.Init();
            Element := Node1.AsXmlElement();
            NodeListSec := Element.GetChildElements();
            foreach Node2 in NodeListSec do begin
                case Node2.AsXmlElement().Name of
                    'codigoCategoria':
                        CategoriaActividadEconomica.Validate(CategoriaActividadEconomica.codigo_Categoria, Node2.AsXmlElement().InnerText);
                    'nombreCategoria':
                        CategoriaActividadEconomica.Validate(CategoriaActividadEconomica.nombreCategoria, Node2.AsXmlElement().InnerText);
                end;
            end;
            CategoriaActividadEconomica.Insert(true);
        end;
    end;


    //------------------------------------------Exportar XML
    procedure XMLExportarCategoriaEconomica()
    var
        XMLDoc: XmlDocument;
        XMLDec: XmlDeclaration;
        RootNode: XmlElement;
        CategoriaEconomica: Record CategoriaActividadEconomica;
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
        CategoriaEconomica.FindSet();

        repeat

            ParentNode := XmlElement.Create('CategoriaEconomica');
            RootNode.add(ParentNode);
            //FieldCaption := Cust.FieldCaption("No.");
            FieldCaption := 'codigoCategoria';
            //Message(FieldCaption);
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(format(CategoriaEconomica.codigo_Categoria));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);


            FieldCaption := 'nombreCategoria';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(CategoriaEconomica.nombreCategoria);
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

        until CategoriaEconomica.Next() = 0;

        TempBlob.CreateInStream(Instr);
        TempBlob.CreateOutStream(Outstr);
        XMLDoc.WriteTo(Outstr);
        Outstr.WriteText(WriteTxt);
        Instr.ReadText(WriteTxt);
        ReadTxt := 'LocalizacionChile_CategoriaEconomica.XML';
        DownloadFromStream(Instr, '', '', '', ReadTxt);
        Message('Se ha descargado correctamente el XML de Categoria actividad económica.');

    end;

}