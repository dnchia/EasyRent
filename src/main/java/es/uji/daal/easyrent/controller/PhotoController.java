package es.uji.daal.easyrent.controller;

import es.uji.daal.easyrent.model.Photo;
import es.uji.daal.easyrent.model.Property;
import es.uji.daal.easyrent.repository.PhotoRepository;
import es.uji.daal.easyrent.repository.PropertyRepository;
import es.uji.daal.easyrent.utils.FileLoader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Created by Alberto on 12/05/2016.
 */

@Controller
@RequestMapping("/uploads")
public class PhotoController {

    @Autowired
    private PhotoRepository repository;

    @Autowired
    private PropertyRepository propertyRepository;

    @Autowired
    private FileLoader fileLoader;

    @ResponseBody
    @RequestMapping(value = "/profile-pics/{imageName}", produces = MediaType.IMAGE_JPEG_VALUE)
    public byte[] getProfileImage(@PathVariable String imageName) throws IOException {
        return Files.readAllBytes(fileLoader.load("profile-pics", imageName).toPath());
    }

    @ResponseBody
    @RequestMapping(value = "/property-pics/{imageName}", produces = MediaType.IMAGE_JPEG_VALUE)
    public byte[] getPropertyPicture(@PathVariable String imageName) throws IOException {
        return Files.readAllBytes(fileLoader.load("property-pics", imageName).toPath());
    }

    @ResponseBody
    @RequestMapping(value = "/property-pics/{imageName}/remove", method = RequestMethod.POST)
    public String removePropertyPicture(@PathVariable String imageName,
                                     @RequestParam("type") String type,
                                     HttpSession session) throws IOException {
        UploadType uploadType = UploadType.valueOf(type.toUpperCase());
        if (uploadType == UploadType.SESSION) {
            Map<String, Object> addProperty = (Map<String, Object>) session.getAttribute("addPropertyMap");
            if (addProperty == null) {
                return "ERROR";
            }
            Set<String> propertyPhotos = (Set<String>) addProperty.get("propertyPhotos");
            if (!propertyPhotos.contains(imageName)) {
                return "ERROR";
            }
            propertyPhotos.remove(imageName);
            // TODO: Remove also on filesystem
        } else {
            Photo photo = repository.findByFilename(imageName);
            Property property = photo.getProperty();
            property.removePhoto(photo);
            propertyRepository.save(property);
            // TODO: Remove also on filesystem
        }
        return "OK";
    }
}
