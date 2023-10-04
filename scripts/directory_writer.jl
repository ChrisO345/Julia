URL_BASE = "https://github.com/TheAlgorithms/Julia/blob/HEAD"

function get_list_files(path, extension=".jl")
    list_files = []
    dir_names = []
    for (root, dirs, files) in walkdir(path)
        current_dir = String[]
        for d in dirs
            # Don't Need??
            if d == "scripts" && d[0] == '.'
                continue
            end
            push!(dir_names, d)
        end
        for file in files
            if file == "directory_writer.jl"
                continue
            end
            if endswith(file, extension)
                push!(current_dir, replace(file, extension => ""))
            end
        end
        if length(current_dir) > 0
            push!(list_files, current_dir)
        end
    end
    return list_files, dir_names
end

function print_directory()
    outputs = "## TheAlgorithms\n"
    files, dirs = get_list_files("../src/")
    for i = eachindex(dirs)
        outputs *= "  * $(uppercasefirst(dirs[i]))\n"
        for j in files[i]
            outputs *= "    * [$j]($URL_BASE/$(dirs[i])/$(replace(j, " " => "%20")).jl)\n"
        end
    end
    open("DIRECTORY.md", "w") do f
        write(f, outputs)
    end
end

print_directory()