import { Optional } from '@nestjs/common';
import {
  IsBoolean,
  IsOptional,
  IsString,
  IsUUID,
  MinLength,
} from 'class-validator';

export class CreateAnswerDto {
  @IsUUID()
  @IsOptional()
  id?: string;

  @IsString()
  @MinLength(3)
  enunciado: string;

  @IsOptional()
  @IsBoolean()
  correcta?: boolean;

  @IsUUID()
  question_id: string;
}
