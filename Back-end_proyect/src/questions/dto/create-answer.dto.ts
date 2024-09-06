import {
  IsBoolean,
  IsOptional,
  IsString,
  IsUUID,
  MinLength,
} from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class CreateAnswerDto {
  @ApiProperty({
    description:
      'Identificador único de la respuesta (opcional en la creación)',
    example: 'd1e9f16b-23b4-4c7f-9187-8fc8f76d8f6c',
    required: false,
  })
  @IsUUID()
  @IsOptional()
  id?: string;

  @ApiProperty({
    description: 'Texto de la respuesta',
    example: 'París',
  })
  @IsString()
  @MinLength(3)
  enunciado: string;

  @ApiProperty({
    description: 'Indica si la respuesta es correcta o no',
    example: true,
    required: false,
  })
  @IsOptional()
  @IsBoolean()
  correcta?: boolean;

  @ApiProperty({
    description: 'Identificador de la pregunta a la que pertenece la respuesta',
    example: 'c1f2d6b7-567b-4d7f-b1c6-d2e9f16b231f',
  })
  @IsUUID()
  question_id: string;
}
