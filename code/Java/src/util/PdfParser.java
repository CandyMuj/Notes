package util;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.util.PDFTextStripper;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;


/**
 * 参考地址：https://www.cnblogs.com/helloIT/p/5074918.html
 * jar下载：https://pdfbox.apache.org/download.cgi#20x
 *
 * @ProJectName APIServer
 * @FileName PdfParser
 * @Description pdf解析工具，可分页读取解析
 * @Author CandyMuj
 * @Date 2019/10/12 15:59
 * @Version 1.0
 */
public class PdfParser {

    public static void main(String[] args) {
        try {
            System.out.println("开始提取");
            File file = new File("D:\\xxx\\xxx.pdf");
            System.out.println("文件绝对路径为：" + file.getAbsolutePath());
            PdfParser.readPdf(file);
            System.out.println("提取结束");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 不分页，读取所有
     */
    public static String readPdfAll(InputStream inputStream) {
        Map<Integer, String> text = readPdf(inputStream, ReadType.ALL);
        return text != null ? text.get(1) : null;
    }

    public static String readPdfAll(File pdfFile) {
        try {
            return readPdfAll(new FileInputStream(pdfFile));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * @return 页码：内容  页码从1开始
     */
    public static Map<Integer, String> readPdf(InputStream inputStream) {
        return readPdf(inputStream, ReadType.BYPAGE);
    }

    public static Map<Integer, String> readPdf(File pdfFile) {
        try {
            return readPdf(new FileInputStream(pdfFile));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


    private static Map<Integer, String> readPdf(InputStream inputStream, ReadType readType) {
        // 是否排序
        boolean sort = false;
        // 内存中存储的PDF Document
        PDDocument document = null;

        try {
            document = PDDocument.load(inputStream);

            int pageCount = document.getNumberOfPages();
            if (pageCount <= 0) return null;

            // PDFTextStripper来提取文本
            PDFTextStripper stripper = new PDFTextStripper();
            // 设置是否排序
            stripper.setSortByPosition(sort);

            Map<Integer, String> textMap = new HashMap<>();
            if (readType == ReadType.ALL) {
                stripper.setStartPage(1);
                stripper.setEndPage(pageCount);
                textMap.put(1, stripper.getText(document));
            } else {
                for (int i = 0; i < pageCount; i++) {
                    int curPage = i + 1;
                    // 设置起始页
                    stripper.setStartPage(curPage);
                    // 设置结束页
                    stripper.setEndPage(curPage);

                    textMap.put(curPage, stripper.getText(document));
                }
            }

            return textMap;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (inputStream != null) {
                    inputStream.close();
                }
                if (document != null) {
                    document.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return null;
    }

    private enum ReadType {
        ALL,
        BYPAGE
    }

}

