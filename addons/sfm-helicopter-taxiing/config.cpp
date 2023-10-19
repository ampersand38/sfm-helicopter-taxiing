class CfgPatches {
    class sfm_helicopter_taxiing {
        name = "SFM Helicopter Taxiing";
        units[] = {};
        weapons[] = {};
        requiredVersion = 1.12;
        requiredAddons[] = {"cba_main"};
        author = "Ampersand";
        authors[] = {"Ampersand"};
        authorUrl = "https://github.com/ampersand38/sfm-helicopter-taxiing";
    };
};

class CfgFunctions {
    class sfmtaxi {	//tag
        class sfm_helicopter_taxiing {	//category
            file  = "sfm-helicopter-taxiing";
            class postInit {
                postInit = 1;
            };
            class input {};
            class pfh {};
        };
    };
};
