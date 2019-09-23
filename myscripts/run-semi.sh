
VERBOSITY=0
DIR=/home/xfbai/mywork/BiAAE-new/src/dict

src=en
lgs=(es fr de ru zh)
#tgt=en
dev=1
random_list=$(python3 -c "import random; random.seed(0); print(' '.join([str(random.randint(0, 1000)) for _ in range(10)]))") # random seeds
#random_list=(497 988)
epath=wiki-ref
echo $random_list
for tgt in ${lgs[@]} 
do
	for s in ${random_list[@]}
	do
		echo $s
		dtrain="$DIR/seed-$s-$src-$tgt.dict"
		python "create_val_split.py" en de $s $dtrain 0
		CUDA_VISIBLE_DEVICES=1 python geomm_semi.py "/data/embeddings/wiki.$src.vec" "/data/embeddings/wiki.$tgt.vec" -dtrain $dtrain -dtest "/data/dictionaries/$src-$tgt.5000-6500.txt" -dtrainspl "train-dict/seed-$s-$src-$tgt.train80.txt" -dvalspl "train-dict/seed-$s-$src-$tgt.train20.txt" --normalize unit center --max_opt_iter 150 --l2_reg 1e-1 --max_vocab 0 --normalize_eval --verbose $VERBOSITY
	done
done
