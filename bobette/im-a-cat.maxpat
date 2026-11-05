{
    "patcher": {
        "fileversion": 1,
        "appversion": {
            "major": 9,
            "minor": 1,
            "revision": 5,
            "architecture": "x64",
            "modernui": 1
        },
        "classnamespace": "box",
        "rect": [ 59.0, 119.0, 1000.0, 780.0 ],
        "boxes": [
            {
                "box": {
                    "id": "obj-5",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 26.333334118127823, 121.33333694934845, 32.0, 22.0 ],
                    "text": "print"
                }
            },
            {
                "box": {
                    "bgcolor": [ 0.9803921568627451, 0.9803921568627451, 0.9803921568627451, 1.0 ],
                    "id": "obj-4",
                    "maxclass": "button",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "outlinecolor": [ 0.9490196078431372, 0.5725490196078431, 1.0, 1.0 ],
                    "parameter_enable": 0,
                    "patching_rect": [ 26.333334118127823, 13.333333730697632, 39.666667848825455, 39.666667848825455 ],
                    "presentation": 1,
                    "presentation_rect": [ 0.0, -0.3333333432674408, 115.33333677053452, 115.33333677053452 ]
                }
            },
            {
                "box": {
                    "id": "obj-2",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 26.333334118127823, 71.33333545923233, 71.0, 22.0 ],
                    "text": "Hi, I'm a cat"
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "obj-5", 0 ],
                    "source": [ "obj-2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-2", 0 ],
                    "source": [ "obj-4", 0 ]
                }
            }
        ],
        "autosave": 0
    }
}