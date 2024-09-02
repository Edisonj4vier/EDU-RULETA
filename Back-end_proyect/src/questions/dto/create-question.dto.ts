import {
  IsArray,
  IsOptional,
  IsString,
  IsUUID,
  MinLength,
} from 'class-validator';
import { Answer } from '../entities/answer.entity';
import { CreateAnswerDto } from './create-answer.dto';

export class CreateQuestionDto {
  @IsString()
  @MinLength(3)
  enunciado: string;

  @IsString()
  @MinLength(20)
  @IsOptional()
  url_video_explicativo?: string;

  @IsUUID()
  topic_id: string;

  @IsArray()
  answers: CreateAnswerDto[];
}
