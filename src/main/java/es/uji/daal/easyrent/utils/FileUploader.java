package es.uji.daal.easyrent.utils;

import org.springframework.web.multipart.MultipartFile;

/**
 * Created by Alberto on 12/05/2016.
 */
public interface FileUploader {
    public String upload(String folder, MultipartFile file);
}
