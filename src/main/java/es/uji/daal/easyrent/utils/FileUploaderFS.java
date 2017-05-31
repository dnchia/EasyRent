package es.uji.daal.easyrent.utils;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.multipart.MultipartFile;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.UUID;

import static org.eclipse.jdt.internal.compiler.parser.Parser.name;

/**
 * Created by Alberto on 12/05/2016.
 */
public class FileUploaderFS implements FileUploader {

    @Value("${easyrent.photos.basedir}")
    private String basedir;

    public String upload(String folder, MultipartFile file) {
        if (!file.isEmpty()) {
            try {
                byte[] bytes = file.getBytes();

                // Creating the directory to store file
                File dir = new File(basedir + File.separator + folder);
                if (!dir.exists())
                    dir.mkdirs();

                // Create the file on server
                File serverFile = new File(dir, UUID.randomUUID().toString().replace("-", ""));
                BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile));
                stream.write(bytes);
                stream.close();

                return serverFile.getName();
            } catch (Exception e) {
                return null;
            }
        } else {
            return null;
        }
    }
}
