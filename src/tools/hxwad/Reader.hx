package hxwad;

typedef Entry = {
    var pointer:Int;
    var size:Int;
    var name:String;
}

class Reader {
    var input:haxe.io.BytesInput;

    public function new(bytes:haxe.io.Bytes) {
        input = new haxe.io.BytesInput(bytes);
    }

    public function process() {
        var file = new File();
        var type = input.readString(4);
        var entriesCount = input.readInt32();
        var offset = input.readInt32();
        var entries:Array<Entry> = [];
        input.position = offset;

        for(i in 0...entriesCount) {
            entries.push(readEntry());
        }

        var occurrences = new Map<String, Int>();

        for(entry in entries) {
            if(!occurrences.exists(entry.name)) {
                occurrences[entry.name] = 0;
            }

            occurrences[entry.name]++;

            switch(entry.name) {
                case "VERTEXES": {
                    var level = file.getLevel(occurrences[entry.name] - 1);
                    input.position = entry.pointer;
                    var count = Std.int(entry.size / 2);
                    level.vertices = [];

                    for(i in 0...count) {
                        var x = input.readInt16();
                        var y = input.readInt16();
                        level.vertices.push({x:x, y:y});
                    }
                }

                case "LINEDEFS": {
                    var level = file.getLevel(occurrences[entry.name] - 1);
                    input.position = entry.pointer;
                    var count = Std.int(entry.size / 14);

                    for(i in 0...count) {
                        var begin = input.readInt16();
                        var end = input.readInt16();
                        var flags = input.readInt16();
                        var type = input.readInt16();
                        var tag = input.readInt16();
                        var rightSidedef = input.readInt16();
                        var leftSidedef = input.readInt16();
                        level.linedefs.push({
                            begin:begin, end:end, flags:flags, type:type, tag:tag, rightSidedef:rightSidedef, leftSidedef:leftSidedef
                        });
                    }
                }
            }
        }

        return file;
    }

    private function readEntry():Entry {
        var pointer = input.readInt32();
        var size = input.readInt32();
        var name = input.readString(8);

        return {
            pointer:pointer,
            size:size,
            name:name
        };
    }
}
