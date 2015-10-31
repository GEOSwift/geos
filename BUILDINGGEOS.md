## Building geos from source

To build geos from source just open the Terminal in the project's root and execute these commands:

```bash
cd geos
make
```

This will download geos source and build it, producing two folders: `include` and `lib`.

To fix the build issue (long-story follows) replace this row in "geos_c.h":

```c
#include <geos/export.h> 
```

with the content of `geos/export.h`.

This is due to a current limitation of Xcode 6.3.2, that can't use bridging headers while building dynamic frameworks. As a consequence, `geos_c.h` must be declared as a public header. `geos_c.h` includes `geos/export.h`, but here the issue seems to be an incompatibility between creating module headers from headers residing in a subfolder..

When the limitation will be over, geos_c.h should be included as a private header, referenced in the Bridging header. This should workaround the limitation related to module headers and folder structure.