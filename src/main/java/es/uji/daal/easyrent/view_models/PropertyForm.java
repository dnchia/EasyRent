package es.uji.daal.easyrent.view_models;

import es.uji.daal.easyrent.model.Property;
import es.uji.daal.easyrent.model.PropertyType;

import javax.persistence.EnumType;
import javax.persistence.Enumerated;

/**
 * Created by Alberto on 16/06/2016.
 */
public class PropertyForm implements ViewModel<Property> {
    private String title;
    private String location;

    @Enumerated(EnumType.STRING)
    private PropertyType type;

    private float pricePerDay;
    private int capacity;
    private int rooms;
    private int bathrooms;
    private int beds;
    private int floorSpace;
    private String description;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public PropertyType getType() {
        return type;
    }

    public void setType(PropertyType type) {
        this.type = type;
    }

    public float getPricePerDay() {
        return pricePerDay;
    }

    public void setPricePerDay(float pricePerDay) {
        this.pricePerDay = pricePerDay;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public int getRooms() {
        return rooms;
    }

    public void setRooms(int rooms) {
        this.rooms = rooms;
    }

    public int getBathrooms() {
        return bathrooms;
    }

    public void setBathrooms(int bathrooms) {
        this.bathrooms = bathrooms;
    }

    public int getBeds() {
        return beds;
    }

    public void setBeds(int beds) {
        this.beds = beds;
    }

    public int getFloorSpace() {
        return floorSpace;
    }

    public void setFloorSpace(int floorSpace) {
        this.floorSpace = floorSpace;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public Property update(Property model) {
        model.setTitle(getTitle());
        model.setLocation(getLocation());
        model.setType(getType());
        model.setPricePerDay(getPricePerDay());
        model.setCapacity(getCapacity());
        model.setRooms(getRooms());
        model.setBathrooms(getBathrooms());
        model.setBeds(getBeds());
        model.setFloorSpace(getFloorSpace());
        model.setDescription(getDescription());
        return model;
    }

    @Override
    public PropertyForm fillUp(Property model) {
        setTitle(model.getTitle());
        setLocation(model.getLocation());
        setType(model.getType());
        setPricePerDay(model.getPricePerDay());
        setCapacity(model.getCapacity());
        setRooms(model.getRooms());
        setBathrooms(model.getBathrooms());
        setBeds(model.getBeds());
        setFloorSpace(model.getFloorSpace());
        setDescription(model.getDescription());
        return this;
    }
}
