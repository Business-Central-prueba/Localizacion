codeunit 50108 XMLTstingSubCategoriaEconomica
{
    procedure ImportarXMLDataSubCategoriaEconomica()
    var
        FromFile: Text;
        Instr: InStream;
        XmlDoc: XmlDocument;
        Tab: XmlElement;
        NodeList: XmlNodeList;
        NodeListSec: XmlNodeList;
        Node1: XmlNode;
        Node2: XmlNode;
        SubCategoriaActividadEconomica: Record SubCategoriaActividad;
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
            SubCategoriaActividadEconomica.Init();
            Element := Node1.AsXmlElement();
            NodeListSec := Element.GetChildElements();
            foreach Node2 in NodeListSec do begin
                case Node2.AsXmlElement().Name of
                    'codigoSubCategoria':
                        SubCategoriaActividadEconomica.Validate(SubCategoriaActividadEconomica.codigo_Subcategoria, Node2.AsXmlElement().InnerText);
                    'nombreSubCategorias':
                        SubCategoriaActividadEconomica.Validate(SubCategoriaActividadEconomica.nombreSubCategorias, Node2.AsXmlElement().InnerText);
                    'codigoCategoria':
                        SubCategoriaActividadEconomica.Validate(SubCategoriaActividadEconomica.Codigo_Categoria, Node2.AsXmlElement().InnerText);
                end;
            end;
            SubCategoriaActividadEconomica.Insert(true);
        end;
    end;


    //------------------------------------------Exportar XML
    procedure XMLExportarSubCategoriaEconomica()
    var
        XMLDoc: XmlDocument;
        XMLDec: XmlDeclaration;
        RootNode: XmlElement;
        SubCategoria: Record SubCategoriaActividad;
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
        SubCategoria.FindSet();

        repeat

            ParentNode := XmlElement.Create('SubCategoriaEconomica');
            RootNode.add(ParentNode);
            FieldCaption := 'codigoSubCategoria';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(format(SubCategoria.codigo_Subcategoria));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);


            FieldCaption := 'nombreSubCategorias';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(SubCategoria.nombreSubCategorias);
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);


            FieldCaption := 'codigoCategoria';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(format(SubCategoria.Codigo_Categoria));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);


        until SubCategoria.Next() = 0;

        TempBlob.CreateInStream(Instr);
        TempBlob.CreateOutStream(Outstr);
        XMLDoc.WriteTo(Outstr);
        Outstr.WriteText(WriteTxt);
        Instr.ReadText(WriteTxt);
        ReadTxt := 'LocalizacionChile_SubcategoriaEconomica.XML';
        DownloadFromStream(Instr, '', '', '', ReadTxt);
        Message('Comenzó descarga de XML subcategorias económicas');
    end;

}