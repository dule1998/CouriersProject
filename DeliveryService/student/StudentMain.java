package student;

import rs.etf.sab.operations.*;
import rs.etf.sab.tests.TestHandler;
import rs.etf.sab.tests.TestRunner;


public class StudentMain {

    public static void main(String[] args) {
        CityOperations cityOperations = new jd170351_CityOperations(); // Change this to your implementation.
        DistrictOperations districtOperations = new jd170351_DistrictOperations(); // Do it for all classes.
        CourierOperations courierOperations = new jd170351_CourierOperations(); // e.g. = new MyDistrictOperations();
        CourierRequestOperation courierRequestOperation = new jd170351_CourierRequestOperation();
        GeneralOperations generalOperations = new jd170351_GeneralOperations();
        UserOperations userOperations = new jd170351_UserOperations();
        VehicleOperations vehicleOperations = new jd170351_VehicleOperations();
        PackageOperations packageOperations = new jd170351_PackageOperations();

        TestHandler.createInstance(
                cityOperations,
                courierOperations,
                courierRequestOperation,
                districtOperations,
                generalOperations,
                userOperations,
                vehicleOperations,
                packageOperations);

        TestRunner.runTests();
    }
}
