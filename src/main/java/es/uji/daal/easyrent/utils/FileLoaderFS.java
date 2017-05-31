package es.uji.daal.easyrent.utils;

import org.springframework.beans.factory.annotation.Value;

import java.io.File;

/**
 * Created by Alberto on 12/05/2016.
 */
public class FileLoaderFS implements FileLoader {

    @Value("${easyrent.photos.basedir}")
    private String basedir;

    @Override
    public File load(String folder, String filename) {
        File dir = new File(basedir + File.separator + folder);
        if (!dir.exists())
            dir.mkdirs();

        return new File(dir, filename);
    }
}
