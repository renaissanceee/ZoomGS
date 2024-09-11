scene="/cluster/work/cvl/jiezcao/jiameng/ZoomGS/ZoomGS/zoomgs_dataset/01"
outputdir="/cluster/work/cvl/jiezcao/jiameng/ZoomGS/ZoomGS/ckpt/zoomgs/01"
#  pretrain base gs with uw image
python zoomgs_train.py -s $scene -m $outputdir --iterations 30000 --eval --port 6014 --stage "uw_pretrain"
##  joint training base gs, camTrans module with uw and w image
python zoomgs_train.py -s $scene -m $outputdir --iterations 30000 --eval --port 6014 --stage "uw2wide"
## test zoomGS results
python zoomgs_test.py -m $outputdir -s $scene --iteration 30000 --target "cx"
## generate camera transition sequences
python zoomgs_render.py -m $outputdir -s $scene --iteration 30000 --target "cx"

module load stack/.2024-04-silent
module load gcc/8.5.0
module load python/3.9
module load cuda/11.8
export PYTHONPATH=
source /cluster/work/cvl/jiezcao/jiameng/ZoomGS/ZoomGS/env/bin/activate

python zoomgs_train.py -s zoomgs_dataset/01 -m ckpt/zoomgs/01 --iteration 30000 --eval --port 6014 --stage "uw_pretrain"
python zoomgs_train.py -s zoomgs_dataset/01 -m ckpt/zoomgs/01 --iteration 30000 --eval --port 6014 --stage "uw2wide"
python zoomgs_render.py -m ckpt/zoomgs/01 --iteration 30000 --target "cx"