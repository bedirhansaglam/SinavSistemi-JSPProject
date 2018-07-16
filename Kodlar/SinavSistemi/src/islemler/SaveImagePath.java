package islemler;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

public class SaveImagePath {

	public boolean Save(String path,String savePath)
	{

		BufferedImage image = null;
        try {
          
        	File url=new File(path);

            image = ImageIO.read(url);
            
            ImageIO.write(image, "jpg",new File(savePath+"\\yeni.jpg"));
            return true;

        } catch (IOException e) {
        	e.printStackTrace();
        	return false;
        }
        
	}
}
