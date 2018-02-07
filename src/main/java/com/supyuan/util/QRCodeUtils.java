/*import java.awt.image.BufferedImage;  
import java.io.File;  
import java.io.FileInputStream;  
import java.io.OutputStream;  
import java.util.HashMap;  
import java.util.Map;  
  
import javax.imageio.ImageIO;  
  
import com.google.zxing.BarcodeFormat;  
import com.google.zxing.Binarizer;  
import com.google.zxing.BinaryBitmap;  
import com.google.zxing.DecodeHintType;  
import com.google.zxing.EncodeHintType;  
import com.google.zxing.LuminanceSource;  
import com.google.zxing.MultiFormatReader;  
import com.google.zxing.MultiFormatWriter;  
import com.google.zxing.Result;  
import com.google.zxing.WriterException;  
import com.google.zxing.client.j2se.BufferedImageLuminanceSource;  
import com.google.zxing.client.j2se.MatrixToImageWriter;  
import com.google.zxing.common.BitMatrix;  
import com.google.zxing.common.HybridBinarizer;  
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;  
  
//二维码工具类（使用ZXingjar包）  
public class QRCodeUtils {  
    // 默认宽为300  
    private Integer width = 300;  
    // 默认高为300  
    private Integer height = 300;  
    // 默认二维码图片格式  
    private String imageFormat = "png";  
    // 默认二维码字符编码  
    private String charType = "utf-8";  
    // 默认二维码的容错级别  
    private ErrorCorrectionLevel corretionLevel = ErrorCorrectionLevel.H;  
    // 二维码与图片的边缘  
    private Integer margin = 1;  
    // 二维码参数  
    private Map<EncodeHintType, Object> encodeHits = new HashMap<>();  
  
    //main方法测试工具类  
    public static void main(String[] args) {  
        QRCodeUtils qrCode=new QRCodeUtils(300,300);  
        //设置二维码的边缘为1  
        qrCode.setMargin(1);  
        //设置输出到桌面  
        String path=System.getProperty("user.home")+File.separator+"Desktop"+File.separator+"test.png";  
        //创建图片二维码  
        qrCode.createQrImage("https://www.baidu.com/", path);  
        //识别图片二维码的内容  
        System.out.println(qrCode.decodeQrImage(new File(path)));//https://www.baidu.com/  
    }  
      
    public QRCodeUtils(Integer width, Integer height, String imageFormat, String charType,  
            ErrorCorrectionLevel corretionLevel, Integer margin) {  
        if (width != null) {  
            this.width = width;  
        }  
        if (height != null) {  
            this.height = height;  
        }  
        if (imageFormat != null) {  
            this.imageFormat = imageFormat;  
        }  
        if (charType != null) {  
            this.charType = charType;  
        }  
        if (corretionLevel != null) {  
            this.corretionLevel = corretionLevel;  
        }  
        if (margin != null) {  
            this.margin = margin;  
        }  
    }  
  
    public QRCodeUtils(Integer width, Integer height, String imageFormat, String charType,  
            ErrorCorrectionLevel corretionLevel) {  
        this(width, height, imageFormat, charType, corretionLevel, null);  
    }  
  
    public QRCodeUtils(Integer width, Integer height, String imageFormat, String charType, Integer margin) {  
        this(width, height, imageFormat, charType, null, margin);  
    }  
  
    public QRCodeUtils(Integer width, Integer height, String imageFormat, String charType) {  
        this(width, height, imageFormat, charType, null, null);  
    }  
  
    public QRCodeUtils(Integer width, Integer height, String imageFormat) {  
        this(width, height, imageFormat, null, null, null);  
    }  
  
    public QRCodeUtils(Integer width, Integer height) {  
        this(width, height, null, null, null, null);  
    }  
  
    public QRCodeUtils() {  
    }  
  
    // 初始化二维码的参数  
    private void initialParamers() {  
        // 字符编码  
        encodeHits.put(EncodeHintType.CHARACTER_SET, this.charType);  
        // 容错等级 L、M、Q、H 其中 L 为最低, H 为最高  
        encodeHits.put(EncodeHintType.ERROR_CORRECTION, this.corretionLevel);  
        // 二维码与图片边距  
        encodeHits.put(EncodeHintType.MARGIN, margin);  
    }  
  
    // 得到二维码图片  
    public BufferedImage getBufferedImage(String content) {  
        initialParamers();  
        BufferedImage bufferedImage = null;  
        try {  
            BitMatrix bitMatrix = new MultiFormatWriter().encode(content, BarcodeFormat.QR_CODE, this.width,  
                    this.height, this.encodeHits);  
            bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix);  
        } catch (WriterException e) {  
            e.printStackTrace();  
            return null;  
        }  
        return bufferedImage;  
    }  
  
    // 将二维码保存到输出流中  
    public void writeToStream(String content, OutputStream os) {  
        initialParamers();  
        try {  
            BitMatrix matrix = new MultiFormatWriter().encode(content, BarcodeFormat.QR_CODE, this.width, this.height,  
                    this.encodeHits);  
            MatrixToImageWriter.writeToStream(matrix, this.imageFormat, os);  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
    }  
  
    // 将二维码图片保存为文件  
    public void createQrImage(String content, File file) {  
        initialParamers();  
        try {  
            BitMatrix matrix = new MultiFormatWriter().encode(content, BarcodeFormat.QR_CODE, this.width, this.height,this.encodeHits);  
            MatrixToImageWriter.writeToFile(matrix, this.imageFormat, file);  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
    }  
  
    // 将二维码图片保存到指定路径  
    public void createQrImage(String content, String path) {  
        initialParamers();  
        try {  
            BitMatrix matrix = new MultiFormatWriter().encode(content, BarcodeFormat.QR_CODE, this.width, this.height,this.encodeHits);  
            MatrixToImageWriter.writeToPath(matrix, this.imageFormat, new File(path).toPath());  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
    }  
      
    //识别图片二维码  
    public String decodeQrImage(File file){  
        String content=null;  
        try {  
            BufferedImage bufferedImage=ImageIO.read(new FileInputStream(file));  
            LuminanceSource source=new BufferedImageLuminanceSource(bufferedImage);  
            Binarizer binarizer=new HybridBinarizer(source);  
            BinaryBitmap image=new BinaryBitmap(binarizer);  
            Map<DecodeHintType,Object> decodeHits=new HashMap<>();  
            decodeHits.put(DecodeHintType.CHARACTER_SET, this.charType);  
            Result result=new MultiFormatReader().decode(image, decodeHits);  
            content=result.getText();  
        }catch (Exception e) {  
            e.printStackTrace();  
        }  
        return content;  
    }  
      
    public Integer getWidth() {  
        return width;  
    }  
  
    public void setWidth(Integer width) {  
        this.width = width;  
    }  
  
    public Integer getHeight() {  
        return height;  
    }  
  
    public void setHeight(Integer height) {  
        this.height = height;  
    }  
  
    public String getImageFormat() {  
        return imageFormat;  
    }  
  
    public void setImageFormat(String imageFormat) {  
        this.imageFormat = imageFormat;  
    }  
  
    public String getCharType() {  
        return charType;  
    }  
  
    public void setCharType(String charType) {  
        this.charType = charType;  
    }  
  
    public ErrorCorrectionLevel getCorretionLevel() {  
        return corretionLevel;  
    }  
  
    public void setCorretionLevel(ErrorCorrectionLevel corretionLevel) {  
        this.corretionLevel = corretionLevel;  
    }  
  
    public Integer getMargin() {  
        return margin;  
    }  
  
    public void setMargin(Integer margin) {  
        this.margin = margin;  
    }  
  
    public Map<EncodeHintType, Object> getHits() {  
        return encodeHits;  
    }  
  
    public void setHits(Map<EncodeHintType, Object> hits) {  
        this.encodeHits = hits;  
    }  
  
}  */