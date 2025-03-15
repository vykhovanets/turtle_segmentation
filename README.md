# Turtle segmentation

## Split video into images
```sh
mkdir -p output_frames_root
for video in *.mov *.MOV; do
  # Skip if no files match the pattern
  [ -e "$video" ] || continue

  basename=$(basename "$video" | sed 's/\.[mM][oO][vV]$//')
  mkdir -p "output_frames_root/$basename"
  ffmpeg -i "$video" -vsync 0 "output_frames_root/$basename/${basename}_frame_%04d.png"
done
```

## Setup local annotation project in Label-Studio
> I am refering to `output_frames_root` and `$basename` - they are from script above

0. Install uv
```sh
curl -LsSf https://astral.sh/uv/install.sh | sh
uv init .
```

1. launch label studio with path to the root folder
```sh
./launch_label_studio.sh <path to "output_frames_root">
```

2. Create a project with interface:
```xml
<View>
   <Header value="Select label and click the image to start"/>
   <Image name="image" value="$image" zoom="true" zoomControl="true" rotateControl="false"/>
   
  <Polygon name="polygon" toName="image" />
  <!-- <Brush name="blush" toName="image" /> -->

  <PolygonLabels name="label" toName="image" strokeWidth="3" pointSize="small" opacity="0.7">
    <Label value="turtle" background="#FFA39E" showInline="true"/>
  </PolygonLabels>

</View>
```

3. Add images as a tasks
```
Project > Settings > Cloud Storage > Add Source Storage
Storage Type = Local Files
Absolute path to folder = <path to "$basename">
Regex = *.png
Treat... = true
```

4. To export use json format (Coco doesn't work for me)

## SAM2 integration
- [SAM2 Example Config](https://github.com/open-mmlab/playground/tree/main/label_anything)
- [SAM2 MPS Config](https://github.com/facebookresearch/sam2/blob/main/demo/README.md)
- [SAM2 Usage](https://www.youtube.com/watch?v=FTg8P8z4RgY)
- [SAM2 Finetuning](https://www.youtube.com/watch?v=mUnvYTZdShk)
- [SAM2 Usage Longer](https://www.youtube.com/watch?v=5tGQAEdKwe4)
