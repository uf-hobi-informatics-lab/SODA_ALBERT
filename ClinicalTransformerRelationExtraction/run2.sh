# example of training and test
export CUDA_VISIBLE_DEVICES=0

bz=4
epn=3
sc=2
dfmm=0
model_type=gatortron
pm=UFNLP/gatortron-base
data_dir=/home/dparedespardo/project/ADE_relation_extraction/datasets/2018umassMADE/distance_specific_data/multiclass/cutoff_1
nmd=/home/dparedespardo/project/ADE_relation_extraction/datasets/2018umassMADE/distance_specific_data/multiclass/models/test_cutoff_1
pof=/home/dparedespardo/project/ADE_relation_extraction/datasets/2018umassMADE/distance_specific_data/multiclass/cutoff_1/test_predictions.txt
log=/home/dparedespardo/project/ADE_relation_extraction/datasets/2018umassMADE/distance_specific_data/multiclass/cutoff_1/test_log.txt

python ./src/relation_extraction.py \
		--model_type $model_type \
		--data_format_mode $dfmm \
		--classification_scheme $sc \
		--pretrained_model $pm \
		--data_dir $data_dir \
		--new_model_dir $nmd \
		--predict_output_file $pof \
		--overwrite_model_dir \
		--seed 13 \
		--max_seq_length 512 \
		--cache_data \
        --do_train \
		--do_predict \
		--do_lower_case \
		--train_batch_size $bz \
		--eval_batch_size $bz \
		--learning_rate 1e-5 \
		--num_train_epochs $epn \
		--gradient_accumulation_steps 1 \
		--do_warmup \
		--warmup_ratio 0.1 \
		--weight_decay 0 \
		--max_num_checkpoints 1 \
		--log_file $log \



edr="/home/dparedespardo/project/ADE_relation_extraction/datasets/2018umassMADE/test_files/brat"
pod="/home/dparedespardo/project/ADE_relation_extraction/datasets/2018umassMADE/distance_specific_data/multiclass/cutoff_1/test_predicted_results"
python src/data_processing/post_processing.py \
		--mode mul \
		--predict_result_file $pof \
		--entity_data_dir $edr \
		--test_data_file ${data_dir}/test.tsv \
		--brat_result_output_dir $pod
